# encoding: UTF-8

module WorldDb


class ReaderBase

  include LogUtils::Logging

## make models available in sportdb module by default with namespace
#  e.g. lets you use City instead of Models::City
  include Models
  include Matcher  # e.g. match_cities_for_country, match_states_for_country, etc.

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper


  def skip_tags?()   @skip_tags == true;  end
  def strict?()      @strict == true;     end


  def initialize( opts={} )
    ## option: do NOT generate/add any tags for countries/states/cities
    @skip_tags =  opts[:skip_tags].present? ? true : false
    ## option: for now issue warning on update, that is, if key/record (country,state,city) already exists
    @strict    =  opts[:strict].present? ? true : false
  end


  def load_setup( name )
    reader = create_fixture_reader( name )

    reader.each do |fixture|
      load( fixture )
    end
  end # method load_setup


  def load( name )

    if name =~ /^continents/
       load_continent_defs( name )
    elsif name =~ /\/continents/
       load_continent_refs( name )
    elsif name =~ /^lang/
       ## todo: pass along opts too
       ## use match_usage( name ) - why? why not?? ???
       r = create_lang_reader( name )
       r.read()
    elsif name =~ /\/lang/
       ## todo: pass along opts too
       ## use match_usage( name ) - why? why not?? ???
       r = create_usage_reader( name )
       r.read()
    elsif name =~ /\/fifa/     ||
          name =~ /\/fips/     ||
          name =~ /\/internet/ ||
          name =~ /\/ioc/      ||
          name =~ /\/iso/      ||
          name =~ /\/motor/
       load_codes( name )
    elsif name =~ /^tag.*\.\d$/
       ## todo: pass along opts too
       ## use match_tags( name ) - why? why not?? ???
       
       ######## FIX: add back again
       ### fix: use read() only, that is, w/o name
       ## r = create_tag_reader( name )
       ## r.read()
    elsif match_countries_for_continent( name ) do |continent|  # # e.g. africa/countries or america/countries
            ### NB: continent changed to regions (e.g. middle-east, caribbean, north-america, etc.)
            ## auto-add continent (from folder structure) as tag
            ## fix: allow dash/hyphen/minus in tag

            ### todo/fix: add opts - how??
            r = create_country_reader( name, tags: continent.tr('-', '_') )
            r.read()
          end
    elsif match_cities_for_country( name ) do |country_key|  #  name =~ /\/([a-z]{2})\/cities/
            ## auto-add required country code (from folder structure)
            country = Country.find_by_key!( country_key )
            logger.debug "Country #{country.key} >#{country.name} (#{country.code})<"

            r = create_city_reader( name, country_id: country.id )
            r.read()
          end
    elsif match_states_abbr_for_country( name ) do |country_key|   # name =~ /\/([a-z]{2})\/states\.abbr/
            load_states_xxx( country_key, 'abbr', name )
          end
    elsif match_states_iso_for_country( name ) do |country_key|  # name =~ /\/([a-z]{2})\/states\.iso/
            load_states_xxx( country_key, 'iso', name )
          end
    elsif match_states_nuts_for_country( name ) do |country_key|  # name =~ /\/([a-z]{2})\/states\.nuts/
            load_states_xxx( country_key, 'nuts', name )
          end
    elsif match_adm3_counties_for_country( name ) do |country_key, state_key, part_name|
            ## auto-add required country code (from folder structure)
            country = Country.find_by_key!( country_key )
            logger.debug "Country #{country.key} >#{country.name} (#{country.code})<"
            state  = State.find_by_key_and_country_id!( state_key, country.id )
            logger.debug "State (ADM1) #{state.key} >#{state.name}<"

            ### todo: move find adm2 to model for (re)use !!!
            part = Part.where( "lower(name) = ? AND state_id = ?",
                                     part_name, state.id ).first   ## check - first needed? returns ary??
            if part.nil?
              logger.error "fix!! - skipping adm3_counties - part (ADM2) '#{part_name}' not found"
              next
            end
            logger.debug "Part (ADM2) #{part.key} >#{part.name}<"

            st = create_county_reader( name, 
                                       state_id: state.id,
                                       part_id: part.id,
                                       level: 3 )   # note: change county level to 3 (default is 2)
            st.read()
          end
    elsif match_adm2_counties_for_country( name ) do |country_key,state_key|
            ## auto-add required country code (from folder structure)
            country = Country.find_by_key!( country_key )
            logger.debug "Country #{country.key} >#{country.name} (#{country.code})<"
            state  = State.find_by_key_and_country_id!( state_key, country.id )
            logger.debug "State (ADM1) #{state.key} >#{state.name}<"

            st = create_county_reader( name,
                                       state_id: state.id,
                                       ## part_id: nil,
                                       level: 2 )
            st.read()
          end
    elsif match_adm2_parts_for_country( name ) do |country_key,state_key|
            ## auto-add required country code (from folder structure)
            country = Country.find_by_key!( country_key )
            logger.debug "Country #{country.key} >#{country.name} (#{country.code})<"
            state  = State.find_by_key_and_country_id!( state_key, country.id )
            logger.debug "State (ADM2) #{state.key} >#{state.name}<"

            st = create_part_reader( name,
                                     state_id: state.id,
                                     level: 2 )
            st.read()
          end
    ### fix: change to match_adm1_states_for_country() - why? why not??
    elsif match_states_for_country( name ) do |country_key|  # name =~ /\/([a-z]{2})\/states/
            ## auto-add required country code (from folder structure)
            country = Country.find_by_key!( country_key )
            logger.debug "Country #{country.key} >#{country.name} (#{country.code})<"

            st = create_state_reader( name,
                                      country_id: country.id,
                                      level: 1 )
            st.read()
          end
    else
      logger.error "unknown world.db fixture type >#{name}<"
      # todo/fix: exit w/ error
    end
  end


  ### use StateAttrReader
  def load_states_xxx( country_key, xxx, name )
    country = Country.find_by_key!( country_key )
    logger.debug "Country #{country.key} >#{country.name} (#{country.code})<"

    reader = create_hash_reader( name )

    reader.each do |key, value|
      state = State.find_by_country_id_and_key!( country.id, key )
      state.send( "#{xxx}=", value )
      state.save!
    end
  end


  ### use ContinentRefReader
  def load_continent_refs( name )
    reader = create_hash_reader( name )

    reader.each do |key, value|
      country = Country.find_by_key!( key )
      continent = Continent.find_by_key!( value )
      country.continent_id = continent.id
      country.save!
    end
  end

  ### use ContinentDef Reader
  def load_continent_defs( name, more_attribs={} )
    reader = create_values_reader( name, more_attribs )

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
  end # load_continent_defs


  def load_codes( name )
    reader = create_line_reader( name )

    reader.each_line do |line|

      values = line.split(',')

      ## logger.debug '[>' + values.join( '<|>' ) + '<]'

      if name =~ /iso/
        # special case for iso
        #  country ref, alpha2, alpha3, num
        country_name = values[0].strip
      else
        #  code, country ref
        country_name = values[1].strip
      end

      ## try to find country
      cty = Country.search_by_name( country_name )

      if cty.nil?
        logger.warn "no country match found for >#{country_name}<; skipping line; in [#{name}]"
        next
      end

      if name =~ /\/fifa/
        cty.fifa = values[0].strip
      elsif name =~ /\/fips/
        cty.fips = values[0].strip
      elsif name =~ /\/internet/
        # NOTE: remove (optional) leading . e.g. .at becomes at
        cty.net  = values[0].sub( /^\s*\./,'' ).strip  
      elsif name =~ /\/ioc/
        cty.ioc = values[0].strip
      elsif name =~ /\/motor/
        cty.motor = values[0].strip
      elsif name =~ /\/iso/
        cty.alpha2 = values[1].strip
        cty.alpha3 = values[2].strip
        # NOTE: num is a string!!! use (rename to) num_str - why? why not?
        cty.num    = values[3].strip
      else
        logger.warn "warn: unknown country code type; skipping line; in [#{name}]"
        next
      end

      cty.save!
    end
  end # method load_codes


####
# helper methods
## todo: also add City.search_by_name etc. !!!


end # class ReaderBase
end # module WorldDb
