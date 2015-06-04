# encoding: utf-8


# core and stlibs

require 'pp'
require 'fileutils'
require 'uri'
require 'erb'
require 'json'
require 'yaml'

require 'logger'    # Note: use for ActiveRecord::Base.logger -- remove/replace later w/ LogUtils::Logger ???


# 3rd party gems / libs

require 'zip'       ## rubyzip gem

require 'props'           # see github.com/rubylibs/props
require 'logutils'        # see github.com/rubylibs/logutils
require 'textutils'       # see github.com/rubylibs/textutils


require 'active_record'   ## todo: add sqlite3? etc.

## add more activerecords addons/utils
require 'tagutils'
require 'activerecord/utils'
require 'props/activerecord'      # includes ConfDb (ConfDb::Model::Prop, etc.)
require 'logutils/activerecord'   # includes LogDb (LogDb::Model::Log, etc.)



# our own code

require 'worlddb/version'   # always goes first

require 'worlddb/patterns'  # regex patterns (constants)
require 'worlddb/models/forward'

require 'worlddb/models/name'
require 'worlddb/models/place'
require 'worlddb/models/continent'
require 'worlddb/models/country'
require 'worlddb/models/country_code'
require 'worlddb/models/state'
require 'worlddb/models/city'
require 'worlddb/models/lang'
require 'worlddb/models/usage'

require 'worlddb/models/tagdb/tag'
require 'worlddb/models/tagdb/tagging'

require 'worlddb/helpers/value_helper'  # Note: extends module TextUtils(!!)::ValueHelper


require 'worlddb/schema'       # Note: requires worlddb/models (include WorldDB::Models)
require 'worlddb/matcher'
require 'worlddb/matcher_adm'

require 'worlddb/readers/lang'
require 'worlddb/readers/usage'
require 'worlddb/readers/country'
require 'worlddb/readers/state'
require 'worlddb/readers/city'

require 'worlddb/reader'
require 'worlddb/reader_file'
require 'worlddb/reader_zip'
require 'worlddb/deleter'
require 'worlddb/stats'


module WorldDb

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


  def self.tables
    Stats.new.tables
  end


  def self.connect( config={} )

    if config.empty?
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


# say hello
puts WorldDb.banner    if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
