###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib lib/worlddb.rb

# core and stlibs

require 'pp'
require 'logger'
require 'optparse'
require 'fileutils'
require 'uri'
require 'erb'
require 'json'
require 'yaml'


# 3rd party gems / libs

require 'zip'       ## rubyzip gem

require 'active_record'   ## todo: add sqlite3? etc.

require 'logutils'
require 'textutils'
require 'tagutils'
require 'props'
require 'props/db'  # includes ConfDb (ConfDb::Model::Prop, etc.)


# our own code

require 'worlddb/version'   # always goes first

require 'worlddb/patterns'  # regex patterns (constants)
require 'worlddb/models/forward'

require 'worlddb/models/name'
require 'worlddb/models/place'
require 'worlddb/models/continent'
require 'worlddb/models/continent_comp'
require 'worlddb/models/country'
require 'worlddb/models/country_comp'
require 'worlddb/models/country_code'
require 'worlddb/models/region'
require 'worlddb/models/region_comp'
require 'worlddb/models/city'
require 'worlddb/models/city_comp'
require 'worlddb/models/lang'
require 'worlddb/models/lang_comp'
require 'worlddb/models/usage'

require 'worlddb/models/tagdb/tag'
require 'worlddb/models/tagdb/tagging'



require 'worlddb/schema'       # NB: requires worlddb/models (include WorldDB::Models)
require 'worlddb/matcher'

require 'worlddb/readers/lang'
require 'worlddb/readers/usage'
require 'worlddb/readers/country'
require 'worlddb/readers/region'
require 'worlddb/readers/city'

require 'worlddb/reader'
require 'worlddb/reader_file'
require 'worlddb/reader_zip'
require 'worlddb/deleter'
require 'worlddb/stats'


module WorldDb

  def self.main
    require 'worlddb/cli/main'
    ## Runner.new.run(ARGV) - old code
  end

  def self.create
    CreateDb.new.up
    ConfDb::Model::Prop.create!( key: 'db.schema.world.version', value: VERSION )
  end

  def self.create_all
    LogDb.create    # add logs table
    ConfDb.create   # add props table
    TagDb.create    # add tags, taggings table
    WorldDb.create
  end


  def self.read( ary, include_path )
    reader = Reader.new( include_path )
    ary.each do |name|
      reader.load( name )
    end
  end


  def self.read_setup( setup, include_path, opts={} )
    reader = Reader.new( include_path, opts )
    reader.load_setup( setup )
  end

  def self.read_setup_from_zip( zip_name, setup, include_path, opts={} ) ## todo/check - use a better (shorter) name ??
    reader = ZipReader.new( zip_name, include_path, opts )
    reader.load_setup( setup )
    reader.close
  end

  def self.read_all( include_path, opts={} )  # load all builtins (using plain text reader); helper for convenience
    read_setup( 'setups/all', include_path, opts )
  end # method read_all


  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting world table records/data...'
    Deleter.new.run
  end # method delete!

  def self.delete_all!( opts={} )
    LogDb.delete!
    ConfDb.delete!
    TagDb.delete!
    WorldDb.delete!
  end


 ####
 ## todo: remove stats ??? why? why not? better use .tables
  def self.stats
    Stats.new.tables
  end

  def self.tables
    Stats.new.tables
  end


  def self.connect( db_config={} )

    if db_config.empty?
      puts "ENV['DATBASE_URL'] - >#{ENV['DATABASE_URL']}<"

      ### change default to ./sport.db ?? why? why not?
      db = URI.parse( ENV['DATABASE_URL'] || 'sqlite3:///world.db' )

      if db.scheme == 'postgres'
        config = {
          adapter: 'postgresql',
          host: db.host,
          port: db.port,
          username: db.user,
          password: db.password,
          database: db.path[1..-1],
          encoding: 'utf8'
        }
      else # assume sqlite3
       config = {
         adapter: db.scheme, # sqlite3
         database: db.path[1..-1] # world.db (NB: cut off leading /, thus 1..-1)
      }
      end
    else
      config = db_config  # use passed in config hash
    end

    ## todo/check: use if defined?( JRUBY_VERSION ) instead ??
    if RUBY_PLATFORM =~ /java/ && config[:adapter] == 'sqlite3' 
      # quick hack for JRuby sqlite3 support via jdbc
      puts "jruby quick hack - adding jdbc libs for jruby sqlite3 database support"
      require 'jdbc/sqlite3'
      require 'active_record/connection_adapters/jdbc_adapter'
      require 'active_record/connection_adapters/jdbcsqlite3_adapter'
    end

    puts "Connecting to db using settings: "
    pp config
    ActiveRecord::Base.establish_connection( config )
    # ActiveRecord::Base.logger = Logger.new( STDOUT )
  end


  def self.setup_in_memory_db

    # Database Setup & Config
    ActiveRecord::Base.logger = Logger.new( STDOUT )
    ## ActiveRecord::Base.colorize_logging = false  - no longer exists - check new api/config setting?

    self.connect( adapter:  'sqlite3',
                  database: ':memory:' )

    ## build schema
    WorldDb.create_all
  end # setup_in_memory_db (using SQLite :memory:)

end  # module WorldDb


if __FILE__ == $0
  WorldDb.main
else
  puts WorldDb.banner    # say hello
end
