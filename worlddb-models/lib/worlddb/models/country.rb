# encoding: utf-8

module WorldDb
  module Model

########
# Country / Supra (e.g. European Union) / Territory (e.g. Puerto Rico) or Dependency (e.g. Dependent territory) 

class Country < ActiveRecord::Base

  extend TextUtils::TagHelper  # will add self.find_tags, self.find_tags_in_attribs!, etc.

  # NB: use extend - is_<type>? become class methods e.g. self.is_<type>? for use in
  #   self.create_or_update_from_values
  extend TextUtils::ValueHelper  # e.g. self.is_year?, self.is_address?, is_taglist? etc.


  self.table_name = 'countries'

  belongs_to :place,     class_name: 'Place',     foreign_key: 'place_id'
  belongs_to :continent, class_name: 'Continent', foreign_key: 'continent_id'

  has_many :usages
  has_many :langs, :through => :usages # lang(uage)s through usages (that is, countries_langs) join table

  has_many :states,  class_name: 'State',  foreign_key: 'country_id'
  has_many :cities,  class_name: 'City',   foreign_key: 'country_id'

  ## self referencing hierachy within countries e.g. EU > GB > EN
  belongs_to :parent,    class_name: 'Country', foreign_key: 'country_id'
  has_many   :countries, class_name: 'Country', foreign_key: 'country_id'
  ### recursive self-reference - use node??
  ## has_many :nodes, class_name: 'State', foregin_key: 'state_id'


  has_many_tags

  validates :key,  format: { with: /#{COUNTRY_KEY_PATTERN}/,  message: COUNTRY_KEY_PATTERN_MESSAGE }
  validates :code, format: { with: /#{COUNTRY_CODE_PATTERN}/, message: COUNTRY_CODE_PATTERN_MESSAGE }

  ## begin compat
  def title()       name;              end
  def title=(value) self.name = value; end

  def synonyms()       alt_names;              end
  def synonyms=(value) self.alt_names = value; end
  ## end


  scope :by_key,   ->{ order( 'key asc' ) }    # order by key (a-z)
  scope :by_name,  ->{ order( 'name asc' ) }   # order by name (a-z)
  scope :by_code,  ->{ order( 'code asc' ) }   # order by code (a-z)
  scope :by_pop,   ->{ order( 'pop desc' ) }   # order by pop(ulation)
  scope :by_area,  ->{ order( 'area desc') }   # order by area (in square km)

  scope :by_num,      ->{ order( 'num asc' ) }   # order by numeric country code
  scope :by_alpha2,   ->{ order( 'alpha2 asc' ) }
  scope :by_alpha3,   ->{ order( 'alpha2 asc' ) }
  scope :by_fifa,     ->{ order( 'fifa asc' ) }   # football
  scope :by_ioc,      ->{ order( 'ioc asc' ) }    # olympics
  scope :by_motor,    ->{ order( 'motor asc' ) }  # designated signs; motor vehicle license plate
  scope :by_net,      ->{ order( 'net asc' ) }    # internet cc top level domain; ccTLD


  before_create :on_create
  before_update :on_update


  def on_create
    place_rec = Place.create!( name: name, kind: place_kind )
    self.place_id = place_rec.id

    if slug.blank?
      ## todo: change and to n  (if en/english) ?? - why? why not?
      ##  remove subtitles/subnames e.g. () -- why? why not?

      ## remove translations []  e.g. México [Mexico] -> México etc.
      self.slug = TextUtils.slugify( name.gsub( /\[[^\]]+\]/, '' ) )
    end
  end

  def on_update
    ## fix/todo: check - if name or kind changed - only update if changed ?? why? why not??
    place.update_attributes!( name: name, kind: place_kind )

    ## check if name changed -- possible?
    ## update slug too??
  end

  def place_kind   # use place_kind_of_code ??
    if is_supra?
      'SUPR'
    elsif is_dependency?
      'TERR'
    elsif is_misc?  ## misc(ellaneous) country or dependent territory
      # todo: use different marker?
      # territory w/ shared or disputes claims e.g Antartica/Western Sahara/Paracel Islands pg Spratly Islands/etc. 
      'MISC'
    else
      'CNTY'
    end
  end


  ###
  #  NB: use is_  for flags to avoid conflict w/ assocs 
  
  def is_supra?()      s? == true;  end
  def is_country?()    c? == true;  end
  def is_dependency?() d? == true;  end
  def is_misc?()       m? == true;  end


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


  def to_path( opts={} )
    # e.g. europe/at-austria
    "#{continent.slug}/#{key}-#{slug}"
  end


  def self.search_by_name( q )    ## todo/check: just use search (rename)? why? why not?

    ## fix: add/configure logger for ActiveRecord!!!
    ## logger = LogKernel::Logger.root

    name = q.strip

    ## 1) first try 1:1 (exact) match
    cty = Country.find_by_name( name )   # NOTE: assume AR escapes quotes in name ??
    if cty.nil?
      ## 2) retry: a) remove all (..) enclosed
      ##           b) remove all extra spaces (e.g. Cocos (Keeling) Islands => Cocos__Islands => Cocos_Islands)
      name = name.gsub( /\([^)]+\)/, '' ).strip
      name = name.gsub( /[ \t]{2,}/, ' ' )
      cty = Country.find_by_name( name )

      ### NOTE: escape ' for sql like clause
      ##   for now use '' for escapes, that is, double quotes
      ##  check - working for postgresql n sqlite?? 
      name_esc = name.gsub( /'/, "''" )

      ## 3) retry: use SQL like match
      ##    % is used to match *zero* or more occurrences of any characters
      ##  todo: check if it matches zero too
      if cty.nil?
        cty = Country.where( "name LIKE '%#{name_esc}%'" ).first
      end

      ## 4) retry: use SQL like match for alternative names match
      if cty.nil?
        cty = Country.where( "alt_names LIKE '%#{name_esc}%'" ).first
      end

      ## 5) retry: use SQL like match for historic names match (e.g. Burma for Myanmar etc.)
      ##  todo/check: make it optional (pass in opts hash to configure) - why? why not???
      if cty.nil?
        cty = Country.where( "hist_names LIKE '%#{name_esc}%'" ).first
      end
    end

    cty  # return cty (country); nil if not found
  end



  def self.parse( *args )
    ## remove (extract) attribs hash (if last arg is a hash n present)
    more_attribs = args.last.is_a?(Hash) ? args.pop : {}  ## extract_options!
    values       = args
  
    self.create_or_update_from_values( values, more_attribs )
  end

  def self.create_or_update_from_values( values, more_attribs={} )

      ## key & title
      ## NB: three-letter code (.e.g AUT) required - enforce in values? why? why not?
      attribs, more_values = find_key_n_title( values )
      attribs = attribs.merge( more_attribs )

      Country.create_or_update_from_attribs( attribs, more_values )
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


      new_attributes[ :c ] = true   # assume country type by default (use supra,depend to change)

      ## check for optional values
      values.each_with_index do |value,index|
        if match_supra_flag( value ) do |_|  # supra(national)
             new_attributes[ :c ] = false   # turn off default c|country flag; make it s|supra only
             new_attributes[ :s ] = true
             ## auto-add tag supra
             value_tag_keys << 'supra'
           end
        elsif match_supra( value ) do |country| # supra:
                new_attributes[ :country_id ] = country.id
              end
        elsif match_country( value ) do |country| # country:
                new_attributes[ :country_id ] = country.id
                new_attributes[ :c ] = false # turn off default c|country flag; make it d|depend only
                new_attributes[ :d ] = true
                ## auto-add tag supra
                value_tag_keys << 'territory'  # rename tag to dependency? why? why not?
              end
        elsif match_km_squared( value ) do |num|  # allow numbers like 453 km²
                value_numbers << num
              end
        elsif match_number( value ) do |num|  # numeric (nb: can use any _ or spaces inside digits e.g. 1_000_000 or 1 000 000)
                value_numbers << num
              end
        elsif value =~ /#{COUNTRY_CODE_PATTERN}/  ## three letter code 
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

      City.parse( value_cities, country_id: rec.id )

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

  end # module Model
end # module WorldDb
