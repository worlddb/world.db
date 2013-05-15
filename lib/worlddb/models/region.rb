# encoding: UTF-8

module WorldDb::Models

class Region < ActiveRecord::Base

  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_hash!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. is_year?, is_region?, is_address?, is_taglist? etc.


  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'

  has_many :cities, :class_name => 'City', :foreign_key => 'region_id'

  has_many :taggings, :as => :taggable
  has_many :tags,     :through => :taggings

  validates :key, :format => { :with => /^[a-z]+$/, :message => 'expected one or more lowercase letters a-z' }
  validates :code, :format => { :with => /^[A-Z_]{2,3}$/, :message => 'expected two or three uppercase letters A-Z (and _)' }, :allow_nil => true


  def title_w_synonyms
    return title if synonyms.blank?
    
    buf = ''
    buf << title
    buf << ' | '
    buf << synonyms.split('|').join(' | ')
    buf
  end


  def self.create_from_ary!( regions, more_attribs={} )
    regions.each do |values|
      Region.create_from_values!( values, more_attribs )
    end # each region
  end

  def self.create_from_values!( values, more_attribs={} )
    ## fix: rename to create_or_update_from_values

    
    ## key & title & country required
    attribs = {
      key:   values[0],
      title: values[1]
    }

    attribs = attribs.merge( more_attribs )
      
    ## check for optional values
    Region.create_or_update_from_values( attribs, values[2..-1] )
  end


  def self.create_or_update_from_values( new_attributes, values, opts={} )
    ## fix: rename to create_or_update_from_attrs/attribs??

    ## opts e.g. :skip_tags true|false

    ## fix: add/configure logger for ActiveRecord!!!
    logger = LogKernel::Logger.root

    value_numbers     = []
    value_tag_keys    = []
    value_cities      = []

    ### check for "default" tags - that is, if present new_attributes[:tags] remove from hash
    value_tag_keys += find_tags_in_hash!( new_attributes )

    ## check for optional values
    values.each_with_index do |value,index|
      if value =~ /^country:/   ## country:
        value_country_key = value[8..-1]  ## cut off country: prefix
        value_country = Country.find_by_key!( value_country_key )
        new_attributes[ :country_id ] = value_country.id
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
    rec = Region.find_by_key_and_country_id( new_attributes[ :key ], new_attributes[ :country_id] )

    if rec.present?
      logger.debug "update Region #{rec.id}-#{rec.key}:"
    else
      logger.debug "create Region:"
      rec = Region.new
    end
      
    logger.debug new_attributes.to_json
   
    rec.update_attributes!( new_attributes )

    #################
    # auto add capital cities

    City.create_or_update_from_titles( value_cities,
                                            region_id:  rec.id,
                                            country_id: rec.country_id )

    ### todo/fix: add captial ref to country/region


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



end # class Region

end # module WorldDb::Models