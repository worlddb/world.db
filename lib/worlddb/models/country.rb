# encoding: utf-8

module WorldDb::Models

class Country < ActiveRecord::Base

  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_hash!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. self.is_year?, self.is_region?, self.is_address?, is_taglist? etc.


  self.table_name = 'countries'

  belongs_to :continent, :class_name => 'Continent', :foreign_key => 'continent_id'
  
  has_many :usages
  has_many :langs, :through => :usages # lang(uage)s through usages (that is, countries_langs) join table

  has_many :regions, :class_name => 'Region', :foreign_key => 'country_id'
  has_many :cities,  :class_name => 'City',   :foreign_key => 'country_id'
  
  ## self referencing hierachy within countries e.g. EU > GB > EN
  belongs_to :parent,    :class_name => 'Country', :foreign_key => 'country_id'
  has_many   :countries, :class_name => 'Country', :foreign_key => 'country_id'

  has_many :taggings, :as => :taggable
  has_many :tags,     :through => :taggings

  validates :key, :format => { :with => /^[a-z]{2}$/, :message => 'expected two lowercase letters a-z' }
  validates :code, :format => { :with => /^[A-Z_]{3}$/, :message => 'expected three uppercase letters A-Z (and _)' }

  scope :by_key,   order( 'key asc' )     # order by key (a-z)
  scope :by_title, order( 'title asc' )   # order by title (a-z)
  scope :by_code,  order( 'code asc' )    # order by code (a-z)
  scope :by_pop,   order( 'pop desc' )    # order by pop(ulation)
  scope :by_area,  order( 'area desc')    # order by area (in square km)
 
  ###
  #  NB: use is_  for flags to avoid conflict w/ assocs 
  
  def is_supra?  
    s? == true
  end
  
  def is_country?
    c? == true
  end
  
  def is_dependency?
    d? == true
  end

 
 
  def title_w_synonyms
    return title if synonyms.blank?
    
    buf = ''
    buf << title
    buf << ' | '
    buf << synonyms.split('|').join(' | ')
    buf
  end


  def self.create_from_ary!( countries )
   countries.each do |values|
      Country.create_from_values!( values )
   end # each country
  end


  def self.create_from_values!( values )
    ## fix: rename to create_or_update_from_values

      ## key & title required
      attribs = {
        :key   => values[0],
        :title => values[1],
        :code  => values[2]
      }
      
      Country.create_or_update_from_values( attribs, values[3..-1] )
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


      new_attributes[ :c ] = true   # assume country type by default (use supra,depend to change)
      
      ## check for optional values
      values.each_with_index do |value,index|
        if value =~ /^supra$/   ## supra(national)
          new_attributes[ :c ] = false   # turn off default c|country flag; make it s|supra only
          new_attributes[ :s ] = true
          ## auto-add tag supra
          value_tag_keys << 'supra'
        elsif value =~ /^supra:/   ## supra:
          value_country_key = value[6..-1]  ## cut off supra: prefix
          value_country = Country.find_by_key!( value_country_key )
          new_attributes[ :country_id ] = value_country.id
        elsif value =~ /^country:/   ## country:
          value_country_key = value[8..-1]  ## cut off country: prefix
          value_country = Country.find_by_key!( value_country_key )
          new_attributes[ :country_id ] = value_country.id
          new_attributes[ :c ] = false # turn off default c|country flag; make it d|depend only
          new_attributes[ :d ] = true
          ## auto-add tag supra
          value_tag_keys << 'territory'  # rename tag to dependency? why? why not?
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
      end

=begin
            # auto-add tags
            area = value_numbers[0]
            pop  = value_numbers[1]
            
            # categorize into brackets
            if area >= 1_000_000
              value_tag_keys << 'area_1_000_000_n_up'
            elsif area >= 100_000
              value_tag_keys << 'area_100_000_to_1_000_000'
            elsif area >= 1000
              value_tag_keys << 'area_1_000_to_100_000'
            else
              value_tag_keys << 'area_1_000_n_less' # microstate
            end

            # include all
            value_tag_keys << 'area_100_000_n_up'  if area >= 100_000
            value_tag_keys << 'area_1_000_n_up'    if area >=   1_000

            
            # categorize into brackets
            if pop >= 100_000_000
              value_tag_keys << 'pop_100m_n_up'
            elsif pop >= 10_000_000
              value_tag_keys << 'pop_10m_to_100m'
            elsif pop >= 1_000_000
              value_tag_keys << 'pop_1m_to_10m'
            else
              value_tag_keys << 'pop_1m_n_less'
            end
            
            # include all
            value_tag_keys << 'pop_10m_n_up'  if pop >= 10_000_000
            value_tag_keys << 'pop_1m_n_up'   if pop >=  1_000_000
=end

      rec = Country.find_by_key( new_attributes[ :key ] )

      if rec.present?
        logger.debug "update Country #{rec.id}-#{rec.key}:"
      else
        logger.debug "create Country:"
        rec = Country.new
      end
      
      logger.debug new_attributes.to_json
   
      rec.update_attributes!( new_attributes )

      #################
      ## auto add capital cities

      City.create_or_update_from_titles( value_cities, country_id: rec.id )

      ##################
      ## add taggings 

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


end # class Country


end # module WorldDb::Models