# encoding: UTF-8

module WorldDb
  module Model


class StateBase < ActiveRecord::Base

  self.abstract_class = true

  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_attribs!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. is_year?, is_address?, is_taglist? etc.

  belongs_to :place,   class_name: 'Place',   foreign_key: 'place_id'

  has_many_tags   # note: check if working w/ base class (statebase) -- use/try concern??

  validates :key,  format: { with: /#{STATE_KEY_PATTERN}/,  message: STATE_KEY_PATTERN_MESSAGE }
  validates :code, format: { with: /#{STATE_CODE_PATTERN}/, message: STATE_CODE_PATTERN_MESSAGE }, allow_nil: true

  ## begin compat
  def title()       name;              end
  def title=(value) self.name = value; end

  def synonyms()       alt_names;              end
  def synonyms=(value) self.alt_names = value; end
  ## end

  before_create :on_create
  before_update :on_update

  def on_create
    place_rec = Place.create!( name: name, kind: place_kind )
    self.place_id = place_rec.id

    ## create name recs -- todo: add default lang etc. - move to: after_create callback!!
    Name.parse( name, alt_names,
                  place_id:   place_rec.id,
                  place_kind: place_rec.kind )
  end

  def on_update
    ## fix/todo: check - if name or kind changed - only update if changed ?? why? why not??
    place.update_attributes!( name: name, kind: place_kind )

    ## todo/fix:
    ## update names too ??
  end


  def all_names( opts={} )
    ### fix:
    ## allow to passing in sep or separator e.g. | or other

    return name if alt_names.blank?
    
    buf = ''
    buf << name
    buf << ' | '
    buf << alt_names.split('|').join(' | ')
    buf
  end


  def self.parse( *args )
    ## remove (extract) attribs hash (if last arg is a hash n present)
    more_attribs = args.last.is_a?(Hash) ? args.pop : {}  ## extract_options!
    values       = args
  
    self.create_or_update_from_values( values, more_attribs )
  end

  def self.create_or_update_from_values( values, more_attribs={} )

    ## key & title & country required
    attribs, more_values = find_key_n_title( values )
    ## fix/hack: change :title to :name
    ## attribs[:name] = attribs[:title]; attribs.delete( :title )
    attribs = attribs.merge( more_attribs )

    ## check for optional values
    puts "[debug] StateBase.create_or_update_from_values calling #{self.name}"  # note: assume self is derived class (object)
    self.create_or_update_from_attribs( attribs, more_values )
  end


  def self.create_or_update_from_attribs( new_attributes, values, opts={} )

    ## opts e.g. :skip_tags true|false

    ## fix: add/configure logger for ActiveRecord!!!
    logger = LogKernel::Logger.root

    value_numbers     = []
    value_tag_keys    = []
    value_cities      = []

    ### check for "default" tags - that is, if present new_attributes[:tags] remove from hash
    value_tag_keys += find_tags_in_attribs!( new_attributes )

    ## check for optional values
    values.each_with_index do |value,index|
      if match_country( value ) do |country| # country:
           new_attributes[ :country_id ] = country.id
         end
      elsif match_km_squared( value ) do |num| # allow numbers like 453 km²
              value_numbers << num
            end
      elsif match_number( value ) do |num|  # numeric (nb: can use any _ or spaces inside digits e.g. 1_000_000 or 1 000 000)
              value_numbers << num
            end
      elsif value =~ /#{STATE_CODE_PATTERN}/  ## assume two or three-letter code
        new_attributes[ :code ] = value
      elsif (values.size==(index+1)) && is_taglist?( value )   # tags must be last entry
        logger.debug "   found tags: >>#{value}<<"
        value_tag_keys += find_tags( value )
      else
          
        ### assume it is the capital city - mark it for auto add
        value_cities << value
        next
   
        # issue warning: unknown type for value
        # logger.warn "unknown type for value >#{value}<"
      end
    end # each value

    if value_numbers.size > 0
      new_attributes[ :area ] = value_numbers[0]
      new_attributes[ :pop  ] = value_numbers[1]
    end  # if value_numbers.size > 0

    ## todo: assert that country_id is present/valid, that is, NOT null
    puts "[debug] StateBase.create_or_update_from_attribs calling #{self.name}.where"  # note: assume self is derived class (object)
    # note: was self.find_by_key_and_country_id
    if self == State
      ## note: state scoped by country (all others by top-level state and NOT country)
      rec = self.find_by(
                    key:         new_attributes[ :key ],
                    country_id:  new_attributes[ :country_id] )
    else
      rec = self.find_by(
                    key:      new_attributes[ :key ],
                    state_id: new_attributes[ :state_id] )
    end

    if rec.present?
      logger.debug "update #{self.name} #{rec.id}-#{rec.key}:"
    else
      logger.debug "create #{self.name}:"    ## e.g. self.name => State, County, Muni, etc.
      puts "[debug] StateBase.create_or_update_from_attribs calling #{self.name}.new"  # note: assume self is derived class (object)
      rec = self.new
    end

    logger.debug new_attributes.to_json

    rec.update_attributes!( new_attributes )

    #################
    # auto add capital cities
    #  - note: get added to top-level state (e.g. adm1)

    City.create_or_update_from_titles( value_cities,
                                            state_id:  rec.state_id,
                                            country_id: rec.country_id )

    ### todo/fix: add captial ref to country/state
    ## todo/fix: use update_from_title and only allow one capital city


    ##################
    # add taggings 

    ## todo/fix: reuse - move add taggings into method etc.

      if value_tag_keys.size > 0
        
        if opts[:skip_tags].present?
          logger.debug "   skipping add taggings (flag skip_tag)"
        else
          value_tag_keys.uniq!  # remove duplicates
          logger.debug "   adding #{value_tag_keys.size} taggings: >>#{value_tag_keys.join('|')}<<..."

          ### fix/todo: check tag_ids and only update diff (add/remove ids)

          value_tag_keys.each do |key|
            tag = Tag.find_by_key( key )
            if tag.nil?  # create tag if it doesn't exit
              logger.debug "   creating tag >#{key}<"
              tag = Tag.create!( key: key )
            end
            rec.tags << tag
          end
        end
      end

    rec

  end # method create_or_update_from_values



end # class State

  end # module Model
end # module WorldDb

