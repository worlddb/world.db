
## $:.unshift(File.dirname(__FILE__))

## minitest setup

# require 'minitest/unit'
require 'minitest/autorun'

# include MiniTest::Unit  # lets us use TestCase instead of MiniTest::Unit::TestCase


# ruby stdlibs

require 'json'
require 'uri'
require 'pp'

# ruby gems

require 'active_record'

# our own code

require 'worlddb'
require 'logutils/db'   # NB: explict require required for LogDb (not automatic) 

Country = WorldDb::Models::Country
Region  = WorldDb::Models::Region
City    = WorldDb::Models::City


def setup_in_memory_db
  # Database Setup & Config

  db_config = {
    adapter:  'sqlite3',
    database: ':memory:'
  }

  pp db_config

  ActiveRecord::Base.logger = Logger.new( STDOUT )
  ## ActiveRecord::Base.colorize_logging = false  - no longer exists - check new api/config setting?

  ## NB: every connect will create a new empty in memory db
  ActiveRecord::Base.establish_connection( db_config )


  ## build schema

  LogDb.create
  WorldDb.create
end


setup_in_memory_db()