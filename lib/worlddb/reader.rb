module WorldDb

class Reader

  include LogUtils::Logging

## make models available in sportdb module by default with namespace
#  e.g. lets you use City instead of Models::City
  include WorldDb::Models

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


  def load_setup( setup )
    ary = load_fixture_setup( setup )

    ### fix/todo:
    #  use to setups - use comment to remove fixtures

    # too big for heroku free db plan (10,000 record limit)
    #  - sorry, can't load by default
    fixture_excludes = [
      'south-america/ve/cities'
    ]
    
    ary = ary - fixture_excludes

    ary.each do |name|
      load( name )
    end
  end # method load_setup


  ## fix/todo: rename ??
  def load_fixture_setup( name )
    
   ## todo/fix: cleanup quick and dirty code
    
    path = "#{include_path}/#{name}.yml"

    logger.info "parsing data '#{name}' (#{path})..."

    text = File.read_utf8( path )
    
    hash = YAML.load( text )
    
    ### build up array for fixtures from hash
    
    ary = []
    
    hash.each do |key_wild, value_wild|
      key   = key_wild.to_s.strip
      
      logger.debug "yaml key:#{key_wild.class.name} >>#{key}<<, value:#{value_wild.class.name} >>#{value_wild}<<"
    
      if value_wild.kind_of?( String ) # assume single fixture name
        ary << value_wild
      elsif value_wild.kind_of?( Array ) # assume array of fixture names as strings
        ary = ary + value_wild
      else
        logger.error "unknow fixture type in setup (yaml key:#{key_wild.class.name} >>#{key}<<, value:#{value_wild.class.name} >>#{value_wild}<<); skipping"
      end
    end
    
    logger.debug "fixture setup:"
    logger.debug ary.to_json
    
    ary
  end # load_fixture_setup


  def load( name )

    if name =~ /^lang/
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
    elsif name =~ /^([a-z][a-z\-]+[a-z])\/countries/     # e.g. africa/countries or america/countries
      ### NB: continent changed to regions (e.g. middle-east, caribbean, north-america, etc.)
      ### fix/cleanup/todo:
      ## auto-add continent (from folder structure) as tag
      ## load_countries( name, include_path, :tags => $1 )
      load_countries( name )
    elsif name =~ /\/([a-z]{2})\/cities/
      ## auto-add required country code (from folder structure)
      load_cities( $1, name )
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


  def load_cities( country_key, name )
    country = Country.find_by_key!( country_key )
    logger.debug "Country #{country.key} >#{country.title} (#{country.code})<"

    load_fixtures_for( City, name, country_id: country.id )
  end



  def with_path_for( name )
    ## todo: find a better name?
    # e.g. find_path_for  or open_fixture_for ??

    path = "#{include_path}/#{name}.yml"

    logger.info "parsing data '#{name}' (#{path})..."
    
    yield( path )
    
    Prop.create_from_fixture!( name, path )
  end



  def load_langs( name )
    
    with_path_for( name ) do |path|
  
      reader = HashReader.new( path )

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
    end # with_path_for

  end # method load_langs


  def load_tags( name, more_values={} )
    
    with_path_for( name ) do |path|

      reader = HashReader.new( path )

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
    
    end # with_path_for
    
  end # method load_tags


  def load_usages( name )
    path = "#{include_path}/#{name}.yml"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = HashReader.new( path )

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

    Prop.create_from_fixture!( name, path )
  end


  def load_xxx( xxx, name )
    path = "#{include_path}/#{name}.yml"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = HashReader.new( path )

    reader.each do |key, value|
      country = Country.find_by_key!( key )
      country.send( "#{xxx}=", value )
      country.save!
    end

    Prop.create_from_fixture!( name, path )
  end


private
  def load_fixtures_for( clazz, more_values={} )  # load from file system
    path = "#{include_path}/#{name}.txt"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = ValuesReader.new( path, more_values )
    
    load_fixtures_worker_for( clazz, reader )

    Prop.create_from_fixture!( name, path )
  end


  def load_fixtures_worker_for( clazz, reader )
   
    ## NB: assumes active activerecord db connection
    ##

    reader.each_line do |attribs, values|
  
      value_numbers     = []
      value_tag_keys    = []
      value_cities      = []
      
      ### check for "default" tags - that is, if present attribs[:tags] remove from hash
      
      if attribs[:tags].present?
        more_tag_keys = attribs[:tags].split('|')
        attribs.delete(:tags)

        ## unify; replace _w/ space; remove leading n trailing whitespace
        more_tag_keys = more_tag_keys.map do |key|
          key = key.gsub( '_', ' ' )
          key = key.strip
          key
        end

        value_tag_keys += more_tag_keys
      end


      if clazz == City
        attribs[ :c ] = true   # assume city type by default (use metro,district to change in fixture)
      elsif clazz == Country
        attribs[ :c ] = true   # assume country type by default (use supra,depend to change)
      end
      
      ## check for optional values
      values.each_with_index do |value,index|
        if value =~ /^region:/   ## region:
          value_region_key = value[7..-1]  ## cut off region: prefix
          ## NB: requires country_id to make unique!
          value_region = Region.find_by_key_and_country_id!( value_region_key, attribs[:country_id] )
          attribs[ :region_id ] = value_region.id
        elsif value =~ /^metro$/   ## metro(politan area)
          attribs[ :c ] = false   # turn off default c|city flag; make it m|metro only
          attribs[ :m ] = true    
        elsif value =~ /^supra$/   ## supra(national)
          attribs[ :c ] = false   # turn off default c|country flag; make it s|supra only
          attribs[ :s ] = true
          ## auto-add tag supra
          value_tag_keys << 'supra'
        elsif value =~ /^supra:/   ## supra:
          value_country_key = value[6..-1]  ## cut off supra: prefix
          value_country = Country.find_by_key!( value_country_key )
          attribs[ :country_id ] = value_country.id
        elsif value =~ /^country:/   ## country:
          value_country_key = value[8..-1]  ## cut off country: prefix
          value_country = Country.find_by_key!( value_country_key )
          attribs[ :country_id ] = value_country.id
          attribs[ :c ] = false # turn off default c|country flag; make it d|depend only
          attribs[ :d ] = true
          ## auto-add tag supra
          value_tag_keys << 'territory'  # rename tag to dependency? why? why not?
        elsif value =~ /^metro:/   ## metro:
          value_city_key = value[6..-1]  ## cut off metro: prefix
          value_city = City.find_by_key!( value_city_key )
          attribs[ :city_id ] = value_city.id
        elsif value =~ /^city:/   ## city:
          value_city_key = value[5..-1]  ## cut off city: prefix
          value_city = City.find_by_key!( value_city_key )
          attribs[ :city_id ] = value_city.id
          attribs[ :c ] = false # turn off default c|city flag; make it d|district only
          attribs[ :d ] = true  
        elsif value =~ /^m:/   ## m:
          value_popm_str = value[2..-1]  ## cut off m: prefix
          value_popm = value_popm_str.gsub(/[ _]/, '').to_i
          attribs[ :popm ] = value_popm
          attribs[ :m ] = true   #  auto-mark city as m|metro too
        elsif value =~ /^[A-Z]{2,3}$/  ## assume two or three-letter code
          attribs[ :code ] = value
        elsif value =~ /(^[0-9]{1,2}$)|(^[0-9][0-9 _]+[0-9]$)/    ## numeric (nb: can use any _ or spaces inside digits e.g. 1_000_000 or 1 000 000)
          value_numbers << value.gsub(/[ _]/, '').to_i
        elsif (values.size==(index+1)) && value =~ /^[a-z0-9\|_ ]+$/   # tags must be last entry

          logger.debug "   found tags: >>#{value}<<"

          tag_keys = value.split('|')
  
          ## unify; replace _w/ space; remove leading n trailing whitespace
          tag_keys = tag_keys.map do |key|
            key = key.gsub( '_', ' ' )
            key = key.strip
            key
          end
          
          value_tag_keys += tag_keys
        else
          
          if clazz == Country || clazz == Region
            ### assume it is the capital city - mark it for auto add
            value_cities << value
            next
          end

          # issue warning: unknown type for value
          logger.warn "unknown type for value >#{value}<"
        end
      end # each value

      
      if value_numbers.size > 0
        if clazz == City
          attribs[ :pop  ] = value_numbers[0]   # assume first number is pop for cities
          attribs[ :area ] = value_numbers[1]  
        else   # countries,regions
          attribs[ :area ] = value_numbers[0]
          attribs[ :pop  ] = value_numbers[1]
          
          if clazz == Country
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
          end
        end
      end

      rec = nil
      
      if clazz == Region  ## requires country_id
        ## todo: assert that country_id is present/valid, that is, NOT null
        rec = clazz.find_by_key_and_country_id( attribs[ :key ], attribs[ :country_id] )
      else
        rec = clazz.find_by_key( attribs[ :key ] )
      end

      if rec.present?
        ## nb: [17..-1] cut off WorldDB::Models:: in name
        logger.debug "update #{clazz.name[17..-1].downcase} #{rec.id}-#{rec.key}:"
      else
        logger.debug "create #{clazz.name[17..-1].downcase}:"
        rec = clazz.new
      end
      
      logger.debug attribs.to_json
   
      rec.update_attributes!( attribs )

      #################
      ## auto add capital cities

      value_cities.each do |city_title|
        
        city_attribs = {}
        city_key = reader.title_to_key( city_title )
        
        ## check if it exists
        ## todo/fix: add country_id for lookup?
        city = City.find_by_key( city_key )
        if city.present?
          logger.debug "update city #{city.id}-#{city.key}:"
        else
          logger.debug "create city:"
          city = City.new
          city_attribs[ :key ] = city_key
        end
        
        city_attribs[ :title ] = city_title
     
        if clazz == Country
          city_attribs[ :country_id ] = rec.id
        elsif clazz == Region
          city_attribs[ :region_id  ] = rec.id
          city_attribs[ :country_id ] = rec.country_id
        else
          ## issue warning: unknown type for city!!!
        end
        
        logger.debug city_attribs.to_json
   
        city.update_attributes!( city_attribs )
        
        ### todo/fix: add captial ref to country/region
        
       end # each city

      
      ##################
      ## add taggings 

      if value_tag_keys.size > 0
        
        if skip_tags?
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

        
    end # each_line
            
  end # method load_fixture_worker_for

  
end # class Reader
end # module WorldDb
