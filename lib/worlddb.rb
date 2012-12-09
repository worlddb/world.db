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

  def self.fixtures  # all builtin fixtures; helper for covenience
     lang_fixtures + 
     tag_fixtures     + []
#     africa_fixtures  + []
#     america_fixtures +
#     europe_fixtures  +
#     asia_fixtures    +
#     oceania_fixtures
  end

  def self.lang_fixtures
    ['langs']
  end

  def self.tag_fixtures
    ['tags.1', 'tags.3']
  end

  def self.africa_fixtures
    ['countries',
    '1_codes/fifa',
    '1_codes/internet',
    '1_codes/iso3'].map { |path| "africa/#{path}" }
  end

  def self.america_fixtures
  ['countries',
   '1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   '1_codes/motor',
   'br/regions',
   'ca/regions',
   'ca/cities',
   'mx/regions',
   'mx/cities',
   'us/regions',
   'us/cities',
   've/regions',
   've/cities'].map { |path| "america/#{path}" }
  end

  def self.asia_fixtures
  ['countries',
   '1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   'jp/cities'].map { |path| "asia/#{path}" }
  end
  
  def self.europe_fixtures
  ['countries',
   '1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   '1_codes/motor',
   'at/regions',
   'at/cities',
   'be/regions',
   'be/cities',
   'bg/cities',
   'by/cities',
   'ch/cities',
   'cy/cities',
   'cz/regions',
   'cz/cities',
   'de/regions',
   'de/cities',
   'dk/cities',
   'ee/cities',
   'en/regions',
   'en/cities',
   'es/regions',
   'es/cities',
   'fi/cities',
   'fr/regions',
   'fr/cities',
   'gr/cities',
   'hr/cities',
   'hu/cities',
   'ie/cities',
   'it/cities',
   'lt/cities',
   'lv/cities',
   'nl/cities',
   'no/cities',
   'pl/cities',
   'pt/cities',
   'ro/cities',
   'rs/cities',
   'ru/cities',
   'sc/cities',
   'se/cities',
   'tr/cities',
   'ua/cities',
   'wa/cities'].map { |path| "europe/#{path}" }
  end

  def self.oceania_fixtures
   ['countries',
   '1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   'au/cities'].map { |path| "oceania/#{path}" }
  end

  ## todo/fix: rename to load/load_all - why? why not?? or just add an alias?

  def self.read( ary )
    reader = Reader.new
    ary.each do |name|
      reader.load_builtin( name )
    end
  end

  def self.read_all  # load all builtins (using plain text reader); helper for convenience
    reader = Reader.new

    # too big for heroku free db plan (10,000 record limit)
    #  - sorry, can't load by default
    fixture_excludes = [
      'america/ve/cities'
    ]
    
    ary = fixtures - fixture_excludes
    
    ary.each do |name|
     reader.load_builtin( name )
    end # each name
  end # method load_all


  class Deleter
    ## todo: move into its own file???    
    
    ## make models available in worlddb module by default with namespace
    #  e.g. lets you use City instead of Models::City 
    include WorldDB::Models

    def run( args=[] )
      # for now delete all tables
      
      Tagging.delete_all
      Tag.delete_all
      City.delete_all
      Region.delete_all
      Country.delete_all
      Usage.delete_all
      Lang.delete_all
      Prop.delete_all
    end
    
  end
  
  # delete ALL records (use with care!)
  def self.delete!
    puts '*** deleting world table records/data...'
    Deleter.new.run
  end # method delete!

  class Stats
    include WorldDB::Models

    def tables
      puts "Stats:"
      puts " #{'%5d' % Country.count} countries (#{Country.where(s: true).count} supras, #{Country.where(d:true).count} deps)"
      puts " #{'%5d' % Region.count} regions"
      puts " #{'%5d' % City.where(m: true).where(c: false).count} metros"
      puts " #{'%5d' % City.where(c: true).count} cities (#{City.where(c: true).where(m: true).count} metros)"
      puts " #{'%5d' % City.where(d: true).count} districts"
      puts " #{'%5d' % Tag.count} tags"
      puts " #{'%5d' % Tagging.count} taggings"
      puts " #{'%5d' % Lang.count} langs"
      puts " #{'%5d' % Usage.count} usages"
    end
    
    def props
      puts "Props:"
      Prop.order( 'created_at asc' ).all.each do |prop|
        puts "  #{prop.key} / #{prop.value} || #{prop.created_at}"
      end
    end
  end

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