# encoding: utf-8

module WorldDb::Models

class City < ActiveRecord::Base
  
  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_hash!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. self.is_year?, self.is_region?, self.is_address?, self.is_taglist? etc.

  
  self.table_name = 'cities'

  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'
  belongs_to :region,  :class_name => 'Region',  :foreign_key => 'region_id'

  ## self referencing hierachy within cities e.g. m|metro > c|city > d|district

  ## fix: use condition check for m|d|c flag?? why? why not? (NB: flags are NOT exclusive e.g. possible metro|city)
  
  ## (1) metro - level up
  has_many   :cities,    :class_name => 'City', :foreign_key => 'city_id'

  ## (2) city
  belongs_to :metro,     :class_name => 'City', :foreign_key => 'city_id'   ## for now alias for parent - use parent?
  has_many   :districts, :class_name => 'City', :foreign_key => 'city_id'   ## for now alias for cities - use cities?

  ## (3) district - level down
  belongs_to :city,      :class_name => 'City', :foreign_key => 'city_id'  ## for now alias for parent - use parent?


  ###
  #  NB: use is_  for flags to avoid conflict w/ assocs (e.g. metro?, city? etc.)
  
  def is_metro?
    m? == true
  end
  
  def is_city?
    c? == true
  end
  
  def is_district?
    d? == true
  end

  
  has_many :taggings, :as => :taggable
  has_many :tags,  :through => :taggings

  validates :key, :format => { :with => /^[a-z]{3,}$/, :message => 'expected three or more lowercase letters a-z' }
  validates :code, :format => { :with => /^[A-Z_]{3}$/, :message => 'expected three uppercase letters A-Z (and _)' }, :allow_nil => true

  scope :by_key,    order( 'key asc' )    # order by key (a-z)
  scope :by_title,  order( 'title asc' )  # order by title (a-z)
  scope :by_pop,    order( 'pop desc' )   # order by pop(ulation)
  scope :by_popm,   order( 'popm desc' )  # order by pop(ulation) metropolitan area
  scope :by_area,   order( 'area desc' )  # order by area (in square km)

  def title_w_synonyms
    return title if synonyms.blank?
    
    buf = ''
    buf << title
    buf << ' | '
    buf << synonyms.split('|').join(' | ')
    buf
  end


  def self.create_from_ary!( cities, more_attribs={} )
    cities.each do |values|
      City.create_from_values!( values, more_attribs )
    end # each city
  end

  ## find: rename to create_or_update_from_values
  def self.create_from_values!( values, more_attribs={} )
    ## key & title & country required
    attribs = {
      key: values[0]
    }
      
    ## title (split of optional synonyms)
    # e.g. FC Bayern Muenchen|Bayern Muenchen|Bayern
    titles = values[1].split('|')
      
    attribs[ :title ]    =  titles[0]
    ## add optional synonyms
    attribs[ :synonyms ] =  titles[1..-1].join('|')  if titles.size > 1
      
    attribs = attribs.merge( more_attribs )
      
    ## check for optional values
    City.create_or_update_from_values( attribs, values[2..-1] )
  end



  def self.create_or_update_from_values( new_attributes, values, opts={} )
  ## fix: rename to create_or_update_from_attrs/attribs/attributes ??
  ##  create_or_update_from_values_v2 ?? or _ii (for step 2) ??
  #   attribs -> key/value pairs e.g. hash
  #   values  -> ary of string values/strings (key not yet known; might be starting of value e.g. city:wien)

    ## opts e.g. :skip_tags true|false

    ## fix: add/configure logger for ActiveRecord!!!
    logger = LogKernel::Logger.root

    value_numbers     = []
    value_tag_keys    = []
      
    ### check for "default" tags - that is, if present new_attributes[:tags] remove from hash
    value_tag_keys += find_tags_in_hash!( new_attributes )

    new_attributes[ :c ] = true   # assume city type by default (use metro,district to change in fixture)

    ## check for optional values
    values.each_with_index do |value,index|
      if value =~ /^region:/   ## region:
        value_region_key = value[7..-1]  ## cut off region: prefix
        ## NB: requires country_id to make unique!
        value_region = Region.find_by_key_and_country_id!( value_region_key, new_attributes[:country_id] )
        new_attributes[ :region_id ] = value_region.id
      elsif value =~ /^metro$/   ## metro(politan area)
        new_attributes[ :c ] = false   # turn off default c|city flag; make it m|metro only
        new_attributes[ :m ] = true    
      elsif value =~ /^country:/   ## country:
        value_country_key = value[8..-1]  ## cut off country: prefix
        value_country = Country.find_by_key!( value_country_key )
        new_attributes[ :country_id ] = value_country.id
      elsif value =~ /^metro:/   ## metro:
        value_city_key = value[6..-1]  ## cut off metro: prefix
        value_city = City.find_by_key!( value_city_key )
        new_attributes[ :city_id ] = value_city.id
      elsif value =~ /^city:/   ## city:
        value_city_key = value[5..-1]  ## cut off city: prefix
        value_city = City.find_by_key!( value_city_key )
        new_attributes[ :city_id ] = value_city.id
        new_attributes[ :c ] = false # turn off default c|city flag; make it d|district only
        new_attributes[ :d ] = true  
      elsif value =~ /^m:/   ## m:
        value_popm_str = value[2..-1]  ## cut off m: prefix
        value_popm = value_popm_str.gsub(/[ _]/, '').to_i
        new_attributes[ :popm ] = value_popm
        new_attributes[ :m ] = true   #  auto-mark city as m|metro too
      elsif is_region?( value )  ## assume region code e.g. TX for city
        value_region = Region.find_by_key_and_country_id!( value.downcase, new_attributes[:country_id] )
        new_attributes[ :region_id ] = value_region.id
      elsif value =~ /^[A-Z]{2,3}$/  ## assume two or three-letter code
        new_attributes[ :code ] = value
      elsif value =~ /^([0-9][0-9 _]+[0-9]|[0-9]{1,2})(?:\s*(?:km2|km²)\s*)$/
        ## allow numbers like 453 km²
        value_numbers << value.gsub( 'km2', '').gsub( 'km²', '' ).gsub(/[ _]/, '').to_i
      elsif value =~ /^([0-9][0-9 _]+[0-9])|([0-9]{1,2})$/    ## numeric (nb: can use any _ or spaces inside digits e.g. 1_000_000 or 1 000 000)
        value_numbers << value.gsub(/[ _]/, '').to_i
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
    end  # if value_numbers.size > 0

    rec = City.find_by_key( new_attributes[ :key ] )

    if rec.present?
      logger.debug "update City #{rec.id}-#{rec.key}:"
    else
      logger.debug "create City:"
      rec = City.new
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

  def self.create_or_update_from_titles( titles, more_attributes = {} )  # ary of titles e.g. ['Wien', 'Graz'] etc.

    # fix: add/configure logger for ActiveRecord!!!
    logger = LogKernel::Logger.root

    titles.each do |title|

      new_attributes = {}
      key = TextUtils.title_to_key( title )   # auto generate key from title

      # check if it exists
      # todo/fix: add country_id for lookup?
      city = City.find_by_key( key )
      if city.present?
        logger.debug "update city #{city.id}-#{city.key}:"
      else
        logger.debug "create city:"
        city = City.new
        new_attributes[ :key ] = key
      end
        
      new_attributes[ :title ] = title
     
      ## merge in passed in attribes (e.g. country_id etc.)
      new_attributes.merge!( more_attributes )
      
      logger.debug new_attributes.to_json
   
      city.update_attributes!( new_attributes )
      
      ### todo/fix: add captial ref to country/region
    end # each city
  end  # method create_or_update_from_titles


end # class Cities

end # module WorldDb::Models