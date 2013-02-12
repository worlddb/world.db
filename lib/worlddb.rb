###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib lib/worlddb.rb

# core and stlibs

require 'yaml'
require 'pp'
require 'logger'
require 'optparse'
require 'fileutils'
require 'erb'

# rubygems

require 'active_record'   ## todo: add sqlite3? etc.


# our own code


require 'worlddb/version'

require 'worlddb/models/prop'
require 'worlddb/models/country'
require 'worlddb/models/region'
require 'worlddb/models/city'
require 'worlddb/models/tag'
require 'worlddb/models/tagging'
require 'worlddb/models/lang'
require 'worlddb/models/usage'
require 'worlddb/schema'       # NB: requires worlddb/models (include WorldDB::Models)
require 'worlddb/utils'
require 'worlddb/readers/code_reader'
require 'worlddb/readers/line_reader'
require 'worlddb/readers/values_reader'
require 'worlddb/readers/hash_reader'
require 'worlddb/reader'
require 'worlddb/deleter'
require 'worlddb/stats'

require 'worlddb/data/fixtures'

require 'worlddb/cli/opts'
require 'worlddb/cli/runner'

module WorldDB

  def self.banner
    "worlddb #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end
  
  # builtin path to fixture data
  def self.data_path
    "#{root}/data"
  end

  def self.main
    Runner.new.run(ARGV)
  end
  
  def self.create
    CreateDB.up
  end


  def self.read( ary, include_path )
    reader = Reader.new
    ary.each do |name|
      reader.load_with_include_path( name, include_path )
    end
  end

  def self.read_all( include_path )  # load all builtins (using plain text reader); helper for convenience
    reader = Reader.new

    # too big for heroku free db plan (10,000 record limit)
    #  - sorry, can't load by default
    fixture_excludes = [
      'america/ve/cities'
    ]
    
    ary = Fixtures.all - fixture_excludes
    
    ary.each do |name|
     reader.load_with_include_path( name, include_path )
    end # each name
  end # method read_all
  
  
  def self.read_setup( setup, include_path )
    ## fix: to be done  (see sport.db.ruby)
  end

  
  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting world table records/data...'
    Deleter.new.run
  end # method delete!

 
  def self.stats
    stats = Stats.new
    stats.tables
    ### stats.props
  end

  def self.tables
    Stats.new.tables
  end

  def self.props
    Stats.new.props
  end

end  # module WorldDB


if __FILE__ == $0
  WorldDB.main
else
  # say hello
  puts WorldDB.banner
end