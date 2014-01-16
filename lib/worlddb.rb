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

# 3rd party gems / libs

require 'active_record'   ## todo: add sqlite3? etc.

require 'logutils'
require 'textutils'


# our own code



require 'worlddb/version'

require 'worlddb/utils'
require 'worlddb/models/prop'
require 'worlddb/models/continent'
require 'worlddb/models/country'
require 'worlddb/models/region'
require 'worlddb/models/city'
require 'worlddb/models/tag'
require 'worlddb/models/tagging'
require 'worlddb/models/lang'
require 'worlddb/models/usage'

module WorldDb
  Models = Model   # note: alias for Model - remove later -- DEPRECIATED!!
end


require 'worlddb/schema'       # NB: requires worlddb/models (include WorldDB::Models)
require 'worlddb/matcher'
require 'worlddb/reader'
require 'worlddb/deleter'
require 'worlddb/stats'


module WorldDb

  def self.banner
    "worlddb #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end

  def self.main
    require 'worlddb/cli/main'
    ## Runner.new.run(ARGV) - old code
  end
  
  def self.create
    CreateDb.new.up
    WorldDb::Model::Prop.create!( key: 'db.schema.world.version', value: VERSION )
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

end  # module WorldDb


if __FILE__ == $0
  WorldDb.main
else
  # say hello
  puts WorldDb.banner
end