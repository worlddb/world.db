# encoding: UTF-8

module WorldDb
  module Model


class State < ActiveRecord::Base

  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_attribs!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. is_year?, is_address?, is_taglist? etc.

  belongs_to :place,   class_name: 'Place',   foreign_key: 'place_id'
  belongs_to :country, class_name: 'Country', foreign_key: 'country_id'

  has_many :cities, class_name: 'City', foreign_key: 'state_id'

  has_many_tags

  validates :key,  format: { with: /#{STATE_KEY_PATTERN}/,  message: STATE_KEY_PATTERN_MESSAGE }
  validates :code, format: { with: /#{STATE_CODE_PATTERN}/, message: STATE_CODE_PATTERN_MESSAGE }, allow_nil: true

  ### recursive self-reference - use "generic" node??
  ## has_many :nodes, class_name: 'State', foreign_key: 'state_id'
  belongs_to :parent,  class_name: 'State', foreign_key: 'state_id'
  has_many   :states,  class_name: 'State', foreign_key: 'state_id'  ## substates


  before_create :on_create
  before_update :on_update

  def on_create
    place_rec = Place.create!( name: name, kind: place_kind )
    self.place_id = place_rec.id 
  end

  def on_update
    ## fix/todo: check - if name or kind changed - only update if changed ?? why? why not??
    place.update_attributes!( name: name, kind: place_kind )
  end

  def place_kind   # use place_kind_of_code ??
    'ADM1'   # note: for now assumes always level 1
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



  def self.create_or_update_from_values( values, more_attribs={} )

    ## key & title & country required
    attribs, more_values = find_key_n_title( values )
    attribs = attribs.merge( more_attribs )

    ## check for optional values
    State.create_or_update_from_attribs( attribs, more_values )
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
    rec = State.find_by_key_and_country_id( new_attributes[ :key ], new_attributes[ :country_id] )

    if rec.present?
      logger.debug "update State #{rec.id}-#{rec.key}:"
    else
      logger.debug "create State:"
      rec = State.new
    end

    logger.debug new_attributes.to_json
   
    rec.update_attributes!( new_attributes )

    #################
    # auto add capital cities

    City.create_or_update_from_titles( value_cities,
                                            state_id:  rec.id,
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
