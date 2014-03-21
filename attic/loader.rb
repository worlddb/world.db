module WorldDb

class Loader

  include LogUtils::Logging


  def run( opts, args )

    args.each do |arg|
      name = arg     # File.basename( arg, '.*' )

      load_fixtures_with_include_path( name, opts.data_path )
    end
    
  end # method run


  class CodeContext
    ## make models available in worlddb module by default with namespace
    #  e.g. lets you use City instead of Models::City 
    include WorldDb::Models
  end

  ### todo: rename to load_fixtures_w_include_path (a little shorter - why? why not?)
  def load_fixtures_with_include_path( name, include_path )  # load from file system
    path = "#{include_path}/#{name}.rb"
 
    puts "*** loading data '#{name}' (#{path})..."

    CodeReader.new( logger, path ).eval( CodeContext )

    # Prop.create!( :key => "db.#{name}.version", :value => WorldDb::VERSION )    
  end

  def load_fixtures_builtin( name ) # load from gem (built-in)
    load_fixtures_with_include_path( name, WorldDb.data_path )
  end


end # class Loader
end # module WorldDb
