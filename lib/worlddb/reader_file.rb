# encoding: UTF-8

module WorldDb

class Reader < ReaderBase

  def initialize( include_path, opts={} )
    super( opts )

    @include_path = include_path
  end


  def create_fixture_reader( name )
    path = "#{@include_path}/#{name}.txt"
    logger.info "parsing data (setup) '#{name}' (#{path})..."

    FixtureReader.from_file( path )
  end

  def create_lang_reader( name )
    path = "#{@include_path}/#{path_to_real_path(name)}.yml"   ## hash reader - use .yml??    
    logger.info "parsing data (lang) '#{name}' (#{path})..."

    LangReader.from_file( path )
  end

  def create_usage_reader( name )
    path = "#{@include_path}/#{path_to_real_path(name)}.yml"   ## hash reader - use .yml??
    logger.info "parsing data (usage) '#{name}' (#{path})..."

    UsageReader.from_file( path )
  end


  def create_country_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"
    logger.info "parsing data (country) '#{name}' (#{path})..."

    CountryReader.from_file( path, more_attribs )
  end

  def create_state_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"

    logger.info "parsing data (state) '#{name}' (#{path})..."

    StateReader.from_file( path, more_attribs )
  end

  def create_part_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"

    logger.info "parsing data (part) '#{name}' (#{path})..."

    PartReader.from_file( path, more_attribs )
  end

  def create_county_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"

    logger.info "parsing data (county) '#{name}' (#{path})..."

    CountyReader.from_file( path, more_attribs )
  end

  def create_muni_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"

    logger.info "parsing data (muni) '#{name}' (#{path})..."

    MuniReader.from_file( path, more_attribs )
  end


  def create_tree_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"
    logger.info "parsing data (state tree) '#{name}' (#{path})..."

    StateTreeReader.from_file( path, more_attribs )
  end


  def create_city_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"
    logger.info "parsing data (city) '#{name}' (#{path})..."

    CityReader.from_file( path, more_attribs )
  end


  def create_hash_reader( name )
    path = "#{@include_path}/#{path_to_real_path(name)}.yml"
    logger.info "parsing data (hash) '#{name}' (#{path})..."

    HashReader.from_file( path )
  end

  def create_values_reader( name, more_attribs={} )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"
    logger.info "parsing data (values) '#{name}' (#{path})..."

    ValuesReader.from_file( path, more_attribs )
  end

  def create_line_reader( name )
    path = "#{@include_path}/#{path_to_real_path(name)}.txt"
    logger.info "parsing data (line) '#{name}' (#{path})..."

    LineReader.from_file( path )
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

end # class Reader
end # module WorldDb
