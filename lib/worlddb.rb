###
# NB: for local testing run like:
#
# 1.9.x: ruby -Ilib lib/worlddb.rb

# core and stlibs

require 'pp'
require 'logger'
require 'optparse'
require 'fileutils'
require 'erb'
require 'json'
require 'yaml'

# 3rd party gems / libs

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

require 'worlddb/readers/base'
require 'worlddb/readers/lang'
require 'worlddb/readers/usage'
require 'worlddb/readers/country'
require 'worlddb/readers/region'
require 'worlddb/readers/city'

require 'worlddb/reader'
require 'worlddb/deleter'
require 'worlddb/stats'
require 'worlddb/stats_comp'


module WorldDb

  def self.main
    require 'worlddb/cli/main'
    ## Runner.new.run(ARGV) - old code
  end

  def self.create
    CreateDb.new.up
    ConfDb::Model::Prop.create!( key: 'db.schema.world.version', value: VERSION )
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

  def self.read_all( include_path, opts={} )  # load all builtins (using plain text reader); helper for convenience
    read_setup( 'setups/all', include_path, opts )
  end # method read_all


  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting world table records/data...'
    Deleter.new.run
  end # method delete!

 ####
 ## todo: remove stats ??? why? why not? better use .tables
  def self.stats
    stats = Stats.new
    stats.tables
    ### stats.props
  end

  def self.tables
    Stats.new.tables
  end

  def self.props
    ### fix: use ConfDb.props delegate or similar !!!
    Stats.new.props
  end

end  # module WorldDb


if __FILE__ == $0
  WorldDb.main
else
  puts WorldDb.banner    # say hello
end
