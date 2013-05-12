# encoding: UTF-8

module WorldDb


  ### fix: move to textutils
  ##   PlusReaderWrapper find a better name than Plus?
  #
  #  todo: also add a ValuesReaderPlus and use it

  class HashReaderPlus
    include LogUtils::Logging

    def initialize( name, include_path )
       @name          = name
       @include_path  = include_path
    end

    attr_reader :name
    attr_reader :include_path

    def each
      path          = "#{include_path}/#{name}.yml"
      reader        = HashReader.new( path )

      logger.info "parsing data '#{name}' (#{path})..."

      reader.each do |key, value|
        yield( key, value )
      end
      
      WorldDb::Models::Prop.create_from_fixture!( name, path )
    end

  end # class HashReaderPlus




class Reader

  include LogUtils::Logging

## make models available in sportdb module by default with namespace
#  e.g. lets you use City instead of Models::City
  include WorldDb::Models
  

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper

  attr_reader :include_path

  def skip_tags?
    @skip_tags == true
  end

  def strict?
    @strict == true
  end

  def initialize( include_path, opts = {} )
    
    @include_path = include_path
    
    ## option: do NOT generate/add any tags for countries/regions/cities
    @skip_tags =  opts[:skip_tags].present? ? true : false
    ## option: for now issue warning on update, that is, if key/record (country,region,city) already exists
    @strict    =  opts[:strict].present? ? true : false
  end


  def load_setup( name )
    path = "#{include_path}/#{name}.yml"

    logger.info "parsing data '#{name}' (#{path})..."

    reader = FixtureReader.new( path )

    # too big for heroku free db plan (10,000 record limit)
    #  - sorry, can't load by default
    fixture_excludes = [
      'south-america/ve/cities'
    ]

    reader.each do |fixture_name|
      next if fixture_excludes.include?( fixture_name )  # skip loading
      
      load( fixture_name )
    end
  end # method load_setup


  def load( name )

    if name =~ /^continents/
       load_continent_defs( name )
    elsif name =~ /\/continents/
       load_continent_refs( name )
    elsif name =~ /^lang/
       load_langs( name )
    elsif name =~ /\/lang/
       load_usages( name )
    elsif name =~ /\/fifa/
       load_xxx( 'fifa', name )
    elsif name =~ /\/iso3/
       load_xxx( 'iso3', name )
    elsif name =~ /\/internet/
       load_xxx( 'net', name )
    elsif name =~ /\/motor/
       load_xxx( 'motor', name )
    elsif name =~ /^tag.*\.(\d)$/
       load_tags( name, :grade => $1.to_i )
    elsif name =~ /^([a-z][a-z\-_]+[a-z])\/countries/     # e.g. africa/countries or america/countries
      ### NB: continent changed to regions (e.g. middle-east, caribbean, north-america, etc.)
      ## auto-add continent (from folder structure) as tag
      ## fix: allow dash/hyphen/minus in tag
      load_countries( name, :tags => $1.tr('-', '_') )
    elsif name =~ /\/([a-z]{2})\/cities/
      ## auto-add required country code (from folder structure)
      load_cities( $1, name )
    elsif name =~ /\/([a-z]{2})\/regions\.abbr/
      load_regions_xxx( $1, 'abbr', name )
    elsif name =~ /\/([a-z]{2})\/regions\.iso/
      load_regions_xxx( $1, 'iso', name )
    elsif name =~ /\/([a-z]{2})\/regions\.nuts/
      load_regions_xxx( $1, 'nuts', name )
    elsif name =~ /\/([a-z]{2})\/regions/
      ## auto-add required country code (from folder structure)
      load_regions( $1, name )
    else
      logger.error "unknown world.db fixture type >#{name}<"
      # todo/fix: exit w/ error
    end
  end
  

  def load_countries( name, more_values={} )
    load_fixtures_for( Country, name, more_values )
  end


  def load_regions( country_key, name )
    country = Country.find_by_key!( country_key )
    logger.debug "Country #{country.key} >#{country.title} (#{country.code})<"

    load_fixtures_for( Region, name, country_id: country.id )
  end


  def load_regions_xxx( country_key, xxx, name )
    country = Country.find_by_key!( country_key )
    logger.debug "Country #{country.key} >#{country.title} (#{country.code})<"

    reader = HashReaderPlus.new( name, include_path )

    reader.each do |key, value|
      region = Region.find_by_country_id_and_key!( country.id, key )
      region.send( "#{xxx}=", value )
      region.save!
    end
  end


  def load_cities( country_key, name )
    country = Country.find_by_key!( country_key )
    logger.debug "Country #{country.key} >#{country.title} (#{country.code})<"

    load_fixtures_for( City, name, country_id: country.id )
  end


  def load_continent_refs( name )
    reader = HashReaderPlus.new( name, include_path )

    reader.each do |key, value|
      country = Country.find_by_key!( key )
      continent = Continent.find_by_key!( value )
      country.continent_id = continent.id
      country.save!
    end
  end


  def load_continent_defs( name, more_values={} )
    path = "#{include_path}/#{name}.txt"

    logger.info "parsing data '#{name}' (#{path})..."

    reader = ValuesReader.new( path, more_values )

    reader.each_line do |attribs, values|

      ## check optional values
      values.each_with_index do |value, index|
        logger.warn "unknown type for value >#{value}<"
      end

      rec = Continent.find_by_key( attribs[ :key ] )
      if rec.present?
        logger.debug "update Continent #{rec.id}-#{rec.key}:"
      else
        logger.debug "create Continent:"
        rec = Continent.new
      end
      
      logger.debug attribs.to_json
   
      rec.update_attributes!( attribs )

    end # each lines
    
    Prop.create_from_fixture!( name, path )
     
  end # load_continent_defs


  def load_langs( name )
    
    reader = HashReaderPlus.new( name, include_path )

    reader.each do |key, value|

        logger.debug "adding lang >>#{key}<< >>#{value}<<..."
      
        lang_key   = key.strip
        lang_title = value.strip
      
        lang_attribs = {}
        
        ## check if it exists
        lang = Lang.find_by_key( lang_key )
        if lang.present?
          logger.debug "update lang #{lang.id}-#{lang.key}:"
        else
          logger.debug "create lang:"
          lang = Lang.new
          lang_attribs[ :key ] = lang_key
        end
        
        lang_attribs[ :title ] = lang_title
        
        logger.debug lang_attribs.to_json
     
        lang.update_attributes!( lang_attribs )
    end # each key,value

  end # method load_langs


  def load_tags( name, more_values={} )
    
      reader = HashReaderPlus.new( name, include_path )

      grade = 1
    
      if more_values[:grade].present?
        grade = more_values[:grade].to_i
      end

      reader.each do |key, value|
        ### split value by comma (e.g. northern america,southern america, etc.)
        logger.debug "adding grade #{grade} tags >>#{key}<< >>#{value}<<..."
        tag_pairs = value.split(',')
        tag_pairs.each do |pair|
        ## split key|title
          values = pair.split('|')
        
          key   = values[0]
          ### remove (optional comment) from key (e.g. carribean (islands))
          key = key.gsub( /\(.+\)/, '' )
          ## remove leading n trailing space
          key = key.strip
        
          title = values[1] || ''  # nb: title might be empty/missing
          title = title.strip
        
          tag_attribs = {}
        
          ## check if it exists
          ## todo/fix: add country_id for lookup?
          tag = Tag.find_by_key( key )
          if tag.present?
            logger.debug "update tag #{tag.id}-#{tag.key}:"
          else
            logger.debug "create tag:"
            tag = Tag.new
            tag_attribs[ :key ] = key
          end
        
          tag_attribs[ :title ] = title
          tag_attribs[ :grade ] = grade
        
          logger.debug tag_attribs.to_json
   
          tag.update_attributes!( tag_attribs )
        end
    end # each key,value

  end # method load_tags


  def load_usages( name )
    reader = HashReaderPlus.new( name, include_path )

    reader.each do |key, value|
      logger.debug "   adding langs >>#{value}<<to country >>#{key}<<"
      
      country = Country.find_by_key!( key )
      
      lang_keys = value.split(',')
      lang_keys.each do |lang_key|

        ### remove (optional comment) from key (e.g. carribean (islands))
        lang_key = lang_key.gsub( /\(.+\)/, '' )
        ## remove leading n trailing space
        lang_key = lang_key.strip

        lang = Lang.find_by_key!( lang_key )
        Usage.create!( country_id: country.id, lang_id: lang.id, official: true, minor: false )
      end
    end
  end


  def load_xxx( xxx, name )
    reader = HashReaderPlus.new( name, include_path )

    reader.each do |key, value|
      country = Country.find_by_key!( key )
      country.send( "#{xxx}=", value )
      country.save!
    end
  end

private
  def load_fixtures_for( clazz, name, more_values={} )  # load from file system
    path = "#{include_path}/#{name}.txt"

    logger.info "parsing data '#{name}' (#{path})..."

    reader = ValuesReader.new( path, more_values )
    
    reader.each_line do |new_attributes, values|
      opts = { skip_tags: skip_tags? }
      clazz.create_or_update_from_values( new_attributes, values, opts )
    end

    Prop.create_from_fixture!( name, path )
  end
  
end # class Reader
end # module WorldDb
