module WorldDB

class Reader

## make models available in sportdb module by default with namespace
#  e.g. lets you use City instead of Models::City
  include WorldDB::Models


  def initialize( logger=nil )
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end
  end

  attr_reader :logger

  def run( opts, args )
 
    args.each do |arg|
      name = arg     # File.basename( arg, '.*' )

      data_path = opts.load? ? WorldDB.data_path : opts.data_path

      if opts.countries?
        load_countries_with_include_path( name, data_path )
      elsif opts.regions?
        load_regions_with_include_path( opts.country, name, data_path )
      elsif opts.cities?
        load_cities_with_include_path( opts.country, name, data_path )
      else
        ## todo: issue a warning here; no fixture type specified; assume country?
      end
    end # each arg

  end


  def load_with_include_path( name, include_path )

    if name =~ /^lang/
       load_langs_with_include_path( name, include_path )
    elsif name =~ /\/lang/
       load_usages_with_include_path( name, include_path )
    elsif name =~ /\/fifa/
       load_xxx_with_include_path( 'fifa', name, include_path )
    elsif name =~ /\/iso3/
       load_xxx_with_include_path( 'iso3', name, include_path )
    elsif name =~ /\/internet/
       load_xxx_with_include_path( 'net', name, include_path )
    elsif name =~ /\/motor/
       load_xxx_with_include_path( 'motor', name, include_path )
    elsif name =~ /^tag.*\.(\d)$/
       load_tags_with_include_path( name, include_path, :grade => $1.to_i )
    elsif name =~ /^([a-z]{3,})\/countries/     # e.g. africa/countries or america/countries
      ## auto-add continent (from folder structure) as tag
      load_countries_with_include_path( name, include_path, :tags => $1 )
    elsif name =~ /\/([a-z]{2})\/cities/
      ## auto-add required country code (from folder structure)
      load_cities_with_include_path( $1, name, include_path )
    elsif name =~ /\/([a-z]{2})\/regions/
      ## auto-add required country code (from folder structure)
      load_regions_with_include_path( $1, name, include_path )
    else
      puts "*** error: unknown world.db fixture type >#{name}<"
      # todo/fix: exit w/ error
    end
  end
  

  def load_builtin( name )  ## convenience helper (requires proper named files w/ convention)
    load_with_include_path( name, WorldDB.data_path )
  end


  def load_countries_with_include_path( name, include_path, more_values={} )
    load_fixtures_with_include_path_for( Country, name, include_path, more_values )
  end

  def load_countries_builtin( name, more_values={} )
    load_countries_with_include_path( name, WorldDB.data_path, more_values )
  end


  def load_regions_with_include_path( country_key, name, include_path )
    country = Country.find_by_key!( country_key )
    puts "Country #{country.key} >#{country.title} (#{country.code})<"

    load_fixtures_with_include_path_for( Region, name, include_path, country_id: country.id )
  end

  def load_regions_builtin( country_key, name )
    load_regions_with_include_path( country_key, name, WorldDB.data_path )
  end


  def load_cities_with_include_path( country_key, name, include_path )
    country = Country.find_by_key!( country_key )
    puts "Country #{country.key} >#{country.title} (#{country.code})<"

    load_fixtures_with_include_path_for( City, name, include_path, country_id: country.id )
  end

  def load_cities_builtin( country_key, name )
    load_cities_with_include_path( country_key, name, WorldDB.data_path )
  end


  def load_langs_with_include_path( name, include_path )
    path = "#{include_path}/#{name}.yml"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = HashReader.new( logger, path )

    reader.each do |key, value|

      puts "adding lang >>#{key}<< >>#{value}<<..."
      
      lang_key   = key.strip
      lang_title = value.strip
      
      lang_attribs = {}
        
      ## check if it exists
      lang = Lang.find_by_key( lang_key )
      if lang.present?
        puts "*** update lang #{lang.id}-#{lang.key}:"
      else
        puts "*** create lang:"
        lang = Lang.new
        lang_attribs[ :key ] = lang_key
      end
        
      lang_attribs[ :title ] = lang_title
        
      puts lang_attribs.to_json
   
      lang.update_attributes!( lang_attribs )
    end # each key,value

    Prop.create_from_worlddb_fixture!( name, path )
  end
  
  def load_langs_builtin( name )
    load_langs_with_include_path( name, WorldDB.data_path )
  end


  def load_tags_with_include_path( name, include_path, more_values={} )
    path = "#{include_path}/#{name}.yml"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = HashReader.new( logger, path )

    grade = 1
    
    if more_values[:grade].present?
      grade = more_values[:grade].to_i
    end

    reader.each do |key, value|
      ### split value by comma (e.g. northern america,southern america, etc.)
      puts "adding grade #{grade} tags >>#{key}<< >>#{value}<<..."
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
          puts "*** update tag #{tag.id}-#{tag.key}:"
        else
          puts "*** create tag:"
          tag = Tag.new
          tag_attribs[ :key ] = key
        end
        
        tag_attribs[ :title ] = title
        tag_attribs[ :grade ] = grade
        
        puts tag_attribs.to_json
   
        tag.update_attributes!( tag_attribs )
      end
    end # each key,value

    Prop.create_from_worlddb_fixture!( name, path )
  end # method load_tags_with_include_path

  def load_tags_builtin( name, include_path, more_values={} )
    load_tags_with_include_path( name, WorldDB.data_path, more_values )
  end


  def load_usages_with_include_path( name, include_path )
    path = "#{include_path}/#{name}.yml"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = HashReader.new( logger, path )

    reader.each do |key, value|
      puts "   adding langs >>#{value}<<to country >>#{key}<<"
      
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

    Prop.create_from_worlddb_fixture!( name, path )
  end
  
  def load_usages_builtin( name )
    load_usages_with_include_path( name, WorldDB.data_path )
  end

  def load_xxx_with_include_path( xxx, name, include_path )
    path = "#{include_path}/#{name}.yml"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = HashReader.new( logger, path )

    reader.each do |key, value|
      country = Country.find_by_key!( key )
      country.send( "#{xxx}=", value )
      country.save!
    end

    Prop.create_from_worlddb_fixture!( name, path )
  end

  def load_xxx_builtin( xxx, name )
    load_xxx_with_include_path( xxx, name, WorldDB.data_path )
  end


private
  def load_fixtures_with_include_path_for( clazz, name, include_path, more_values={} )  # load from file system
    path = "#{include_path}/#{name}.txt"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = ValuesReader.new( logger, path, more_values )
    
    load_fixtures_worker_for( clazz, reader )

    Prop.create_from_worlddb_fixture!( name, path )
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

          puts "   found tags: >>#{value}<<"

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
          puts "!!!! >>>> warning: unknown type for value >#{value}<"
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
        puts "*** update #{clazz.name[17..-1].downcase} #{rec.id}-#{rec.key}:"
      else
        puts "*** create #{clazz.name[17..-1].downcase}:"
        rec = clazz.new
      end
      
      puts attribs.to_json
   
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
          puts "*** update city #{city.id}-#{city.key}:"
        else
          puts "*** create city:"
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
        
        puts city_attribs.to_json
   
        city.update_attributes!( city_attribs )
        
        ### todo/fix: add captial ref to country/region
        
       end # each city

      
      ##################
      ## add taggings 

      if value_tag_keys.size > 0

        value_tag_keys.uniq!  # remove duplicates
        puts "   adding #{value_tag_keys.size} taggings: >>#{value_tag_keys.join('|')}<<..."

        ### fix/todo: check tag_ids and only update diff (add/remove ids)

        value_tag_keys.each do |key|
          tag = Tag.find_by_key( key )
          if tag.nil?  # create tag if it doesn't exit
            puts "   creating tag >#{key}<"
            tag = Tag.create!( key: key )
          end
          rec.tags << tag
        end
      end

        
    end # each_line
            
  end # method load_fixture_worker_for

  
end # class Reader
end # module WorldDB
