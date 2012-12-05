module WorldDB

class Loader

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
      
      if opts.load?
        load_fixtures_builtin( name )
      else
        load_fixtures_with_include_path( name, opts.data_path )
      end
    end
    
  end # method run


  class CodeContext
    ## make models available in worlddb module by default with namespace
    #  e.g. lets you use City instead of Models::City 
    include WorldDB::Models
  end

  ### todo: rename to load_fixtures_w_include_path (a little shorter - why? why not?)
  def load_fixtures_with_include_path( name, include_path )  # load from file system
    path = "#{include_path}/#{name}.rb"
 
    puts "*** loading data '#{name}' (#{path})..."

    CodeReader.new( logger, path ).eval( CodeContext )

    # Prop.create!( :key => "db.#{name}.version", :value => WorldDB::VERSION )    
  end

  def load_fixtures_builtin( name ) # load from gem (built-in)
    load_fixtures_with_include_path( name, WorldDB.data_path )
  end


end # class Loader
end # module WorldDB
