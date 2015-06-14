# encoding: utf-8

module WorldDb
  module Model


class CityBase < ActiveRecord::Base

  self.abstract_class = true

  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_attribs!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. self.is_year?, self.is_address?, self.is_taglist? etc.

  belongs_to :place,   class_name: 'Place',   foreign_key: 'place_id'

  has_many_tags

  ## begin compat
  def title()        name;              end
  def title=(value)  self.name = value; end

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

  validates :key,  format: { with: /#{CITY_KEY_PATTERN}/, message: CITY_KEY_PATTERN_MESSAGE }
  validates :code, format: { with: /#{CITY_CODE_PATTERN}/, message: CITY_CODE_PATTERN_MESSAGE }, allow_nil: true


  scope :by_key,   ->{ order( 'key asc' )  }  # order by key (a-z)
  scope :by_name,  ->{ order( 'name asc' ) } # order by title (a-z)
  scope :by_pop,   ->{ order( 'pop desc' ) }  # order by pop(ulation)
  scope :by_area,  ->{ order( 'area desc' ) }  # order by area (in square km)


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

    ## check if array passed in for batch (multi record) parse
    ##  - fix/todo: add to all other parse model methods too!!!! it's a standard (feature)
    if args.size == 1 && args[0].is_a?(Array)
      ## e.g. City.parse( [ 'Vienna', 'Salzburg' ] )
      ##  note: works for now only w/ *single* name/title records
      ##  add support for array in array too - why? why not?
      ##  e.g. City.parse( [['Vienna', 'VIE'],
      ##                    ['Salzbrug', 'SZB']] )
      ary = args[0]
      ## note: return array of new objs
      ary.map { |value| self.create_or_update_from_values( [value], more_attribs ) }
    else
      ## standard (sinlge) record case
      ##  e.g.  City.parse( 'Vienna', 'VIE', '1 800 000' )
      values  = args
      self.create_or_update_from_values( values, more_attribs )
    end
  end


  def self.create_or_update_from_values( values, more_attribs={} )
    ## key & title & country required

    attribs, more_values = find_key_n_title( values )
    attribs = attribs.merge( more_attribs )

    ## check for optional values
    self.create_or_update_from_attribs( attribs, more_values )
  end

  def self.create_or_update_from_attribs( new_attributes, values, opts={} )
    #   attribs -> key/value pairs e.g. hash
    #   values  -> ary of string values/strings (key not yet known; might be starting of value e.g. city:wien)

    ## opts e.g. :skip_tags true|false

    ## fix: add/configure logger for ActiveRecord!!!
    logger = LogKernel::Logger.root

    value_numbers     = []
    value_tag_keys    = []
      
    ### check for "default" tags - that is, if present new_attributes[:tags] remove from hash
    value_tag_keys += find_tags_in_attribs!( new_attributes )

    city_class = City  # assume city type by default (use metro,district to change in fixture)
    new_attributes_metro = {}

    ## check for optional values

    values.each_with_index do |value,index|
      if match_state_for_country( value, new_attributes[:country_id] ) do |state|
           new_attributes[ :state_id ] = state.id
         end
      elsif match_country( value ) do |country|
              new_attributes[ :country_id ] = country.id
            end
      elsif match_metro( value ) do |metro|
              new_attributes[ :metro_id ] = metro.id
            end
      elsif match_metro_pop( value ) do |num|  # e.g  m: 1 444 444
              new_attributes_metro[ :pop ] = num    # note: gets added to **metro** attributes; triggers auto-added metro record
            end
      elsif match_metro_flag( value ) do |_|  # metro(politan area)
              city_class = Metro    # turn off default c|city flag; make it m|metro only
            end
      elsif match_city( value ) do |city|  # parent city for district
              new_attributes[ :city_id ] = city.id
              city_class = District # turn off default c|city flag; make it d|district only 
            end
      elsif match_km_squared( value ) do |num|   # allow numbers like 453 km²
              value_numbers << num
            end
      elsif match_number( value ) do |num|    # numeric (nb: can use any _ or spaces inside digits e.g. 1_000_000 or 1 000 000)
              value_numbers << num
            end
      elsif value =~ /#{CITY_CODE_PATTERN}/  ## assume three-letter code
        new_attributes[ :code ] = value
      elsif (values.size==(index+1)) && is_taglist?( value )   # tags must be last entry
        logger.debug "   found tags: >>#{value}<<"
        value_tag_keys += find_tags( value )
      else
        # issue warning: unknown type for value
        logger.warn "unknown type for value >#{value}<"
      end
    end # each value

    if value_numbers.size > 0
      new_attributes[ :pop  ] = value_numbers[0]   # assume first number is pop for cities
      new_attributes[ :area ] = value_numbers[1]  
    end


      #######
      ## auto add metro if used M:/m: shortcut
      if new_attributes_metro.empty? == false
        new_attributes_metro[:key]        = new_attributes[:key]
        ## todo/fix: use title or name?
        new_attributes_metro[:name]       = new_attributes[:name] || new_attributes[:title]
        new_attributes_metro[:country_id] = new_attributes[:country_id]

        metro_rec = Metro.find_by_key( new_attributes_metro[ :key ] )

        if metro_rec.present?
          logger.debug "(auto-)update Metro #{metro_rec.id}-#{metro_rec.key}:"
        else
          logger.debug "(auto-)create Metro:"
          metro_rec = Metro.new
        end

        logger.debug new_attributes_metro.to_json

        metro_rec.update_attributes!( new_attributes_metro )
        new_attributes[:metro_id] = metro_rec.id
      end


    rec = city_class.find_by_key( new_attributes[ :key ] )

    if rec.present?
      logger.debug "update #{city_class.name} #{rec.id}-#{rec.key}:"
    else
      logger.debug "create #{city_class.name}:"
      rec = city_class.new
    end

    logger.debug new_attributes.to_json

    rec.update_attributes!( new_attributes )


      ##################
      ## add taggings

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


end # class Cities

  end # module Model
end # module WorldDb
