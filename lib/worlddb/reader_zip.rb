# encoding: UTF-8

module WorldDb

class ZipReader < ReaderBase


  def initialize( name, include_path, opts = {} )
    super( opts )

    ## todo/fix: make include_path an opts (included in opts?) - why? why not??
    path = "#{include_path}/#{name}.zip"
    
    ## todo: check if zip exists
    @zip_file = Zip::File.open( path ) ## NOTE: do NOT create if file is missing; let it crash

    ### allow prefix (path) in name
    ### e.g. assume all files relative to setup manifest
    ## e.g. at-austria-master/setups/all.txt or
    ## be-belgium-master/setups/all.txt
    ## for
    ## setups/all.txt
    ###
    ## will get (re)set w/ fixture/setup reader
    ##
    ## todo/fix: change/rename to @relative_path ?? - why? why not?
    @zip_prefix = ''
  end

  def close
    ## todo/check: add a close method - why? why not ???
    @zip_file.close
  end



  def create_fixture_reader( name )
    ## e.g. pass in => setups/all or setups/test etc. e.g. w/o .txt extension
    query = "**/#{name}.txt"

    ## note: returns an array of Zip::Entry
    candidates = @zip_file.glob( query )
    pp candidates

    ## use first candidates entry as match
    ## todo/fix: issue warning if more than one entries/matches!!

    ## get fullpath e.g. at-austria-master/setups/all.txt
    path = candidates[0].name
    logger.debug "  zip entry path >>#{path}<<"

    ## cut-off at-austria-master/    NOTE: includes trailing slash (if present)
    ## logger.debug "  path.size #{path.size} >>#{path}<<"
    ## logger.debug "  name.size #{name.size+4} >>#{name}<<"

    ## note: add +4 for extension (.txt)
    @zip_prefix = path[ 0...(path.size-(name.size+4)) ]
    logger.debug "  zip entry prefix >>#{@zip_prefix}<<"

    logger.info "parsing data (setup) in zip '#{name}' (#{path})..."

    FixtureReader.from_zip( @zip_file, path )
  end


  def create_lang_reader( name )
    path = name_to_zip_entry_path( name, '.yml' )  ## hash reader - use .yml??
    logger.info "parsing data (lang) in zip '#{name}' (#{path})..."

    LangReader.from_zip( @zip_file, path )
  end

  def create_usage_reader( name )
    path = name_to_zip_entry_path( name, '.yml' )  ## hash reader - use .yml??
    logger.info "parsing data (usage) in zip '#{name}' (#{path})..."

    UsageReader.from_zip( @zip_file, path )
  end


  def create_country_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (country) in zip '#{name}' (#{path})..."

    CountryReader.from_zip( @zip_file, path, more_attribs )
  end

  def create_state_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (state) in zip '#{name}' (#{path})..."

    StateReader.from_zip( @zip_file, path, more_attribs )
  end

  def create_part_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (part) in zip '#{name}' (#{path})..."

    PartReader.from_zip( @zip_file, path, more_attribs )
  end

  def create_county_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (county) in zip '#{name}' (#{path})..."

    CountyReader.from_zip( @zip_file, path, more_attribs )
  end

  def create_muni_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (muni) in zip '#{name}' (#{path})..."

    MuniReader.from_zip( @zip_file, path, more_attribs )
  end



  def create_city_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (city) in zip '#{name}' (#{path})..."

    CityReader.from_zip( @zip_file, path, more_attribs )
  end


  def create_hash_reader( name )
    path = name_to_zip_entry_path( name, '.yml' )  ## hash reader - use .yml??
    logger.info "parsing data (hash) in zip '#{name}' (#{path})..."

    HashReader.from_zip( @zip_file, path )
  end

  def create_values_reader( name, more_attribs={} )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (values) in zip '#{name}' (#{path})..."

    ValuesReader.from_zip( @zip_file, path, more_attribs )
  end

  def create_line_reader( name )
    path = name_to_zip_entry_path( name )
    logger.info "parsing data (line) in zip '#{name}' (#{path})..."

    LineReader.from_zip( @zip_file, path )
  end

#  def create_tag_reader( name )
#    ## fix: change to new from_file() style
#    TagDb::TagReader.new( @include_path )
#  end

private

  def path_to_real_path( path )
    # map name to name_real_path
    # name might include !/ for virtual path (gets cut off)
    # e.g. at-austria!/w-wien/beers becomse w-wien/beers
    pos = path.index( '!/')
    if pos.nil?
      path # not found; real path is the same as name
    else
      # cut off everything until !/ e.g.
      # at-austria!/w-wien/beers becomes
      # w-wien/beers
      path[ (pos+2)..-1 ]
    end
  end

  def name_to_zip_entry_path( name, extension='.txt' )
    path = "#{name}#{extension}"

    real_path = path_to_real_path( path )

    # NOTE: add possible zip entry prefix path
    #          (if present includes trailing slash e.g. /)
    entry_path = "#{@zip_prefix}#{real_path}"
    entry_path
  end



end # class ZipReader
end # module WorldDb
