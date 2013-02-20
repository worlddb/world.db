# encoding: utf-8

require 'commander/import'

require 'worlddb/cli/opts'



program :name,  'worlddb'
program :version, WorldDB::VERSION
program :description, "world.db command line tool, version #{WorldDB::VERSION}"


# default_command :help
default_command :load

program :help_formatter, Commander::HelpFormatter::TerminalCompact

## program :help, 'Examples', 'yada yada -try multi line later'

=begin
### add to help use new sections

Examples:
    worlddb at/cities                      # import austrian cities
    worlddb --create                       # create database schema

More Examples:
    worlddb                                # show stats (table counts, table props)

Further information:
  http://geraldb.github.com/world.db=end
=end


## todo: find a better name e.g. change to settings? config? safe_opts? why? why not?
myopts = WorldDB::Opts.new

### global option (required)
## todo: add check that path is valid?? possible?

global_option '-i', '--include PATH', String, "Data path (default is #{myopts.data_path})"
global_option '-d', '--dbpath PATH', String, "Database path (default is #{myopts.db_path})"
global_option '-n', '--dbname NAME', String, "Database name (datault is #{myopts.db_name})"


def connect_to_db( options )
  puts WorldDB.banner

  puts "working directory: #{Dir.pwd}"

  db_config = {
    :adapter  => 'sqlite3',
    :database => "#{options.db_path}/#{options.db_name}"
  }

  puts "Connecting to db using settings: "
  pp db_config

  ActiveRecord::Base.establish_connection( db_config )
end


command :create do |c|
  c.syntax = 'worlddb create [options]'
  c.description = 'Create DB schema'
  c.action do |args, options|
    myopts.merge_commander_options!( options.__hash__ )
    connect_to_db( myopts )
    
    LogDB.create
    WorldDB.create
    puts 'Done.'
  end # action
end # command create

command :setup do |c|
  c.syntax = 'worlddb setup [options]'
  c.description = "Create DB schema 'n' load all data"

  c.option '--delete', 'Delete all records'

  c.action do |args, options|
    myopts.merge_commander_options!( options.__hash__ )
    connect_to_db( myopts )

    if options.delete.present?
      # w/ delete flag assume tables already exit
      WorldDB.delete!
    else
      LogDB.create
      WorldDB.create
    end

    WorldDB.read_all( myopts.data_path )
    puts 'Done.'
  end # action
end  # command setup

command :load do |c|
  ## todo: how to specify many fixutes <>... ??? in syntax
  c.syntax = 'worlddb load [options] <fixtures>'
  c.description = 'Load fixtures'

  c.option '--country KEY', String, "Default country for regions 'n' cities"
  
  ### todd/check - type flags still needed? dispatch using name and convention?
  c.option '--countries', 'Use country plain text fixture reader'
  c.option '--regions',   'Use regions plain text fixture reader'
  c.option '--cities',    'Use cities  plain text fixture reader'

  c.option '--delete', 'Delete all records'

  c.action do |args, options|
    myopts.merge_commander_options!( options.__hash__ )
    connect_to_db( myopts )
    
    WorldDB.delete! if options.delete.present?

    # read plain text country/region/city fixtures
    reader = WorldDB::Reader.new  # todo: add logger here?
    args.each do |arg|
      name = arg     # File.basename( arg, '.*' )

      if myopts.countries?
        reader.load_countries_with_include_path( name, myopts.data_path )
      elsif myopts.regions?
        reader.load_regions_with_include_path( myopts.country, name, myopts.data_path )
      elsif myopts.cities?
        reader.load_cities_with_include_path( myopts.country, name, myopts.data_path )
      else
        reader.load_with_include_path( name, myopts.data_path )
        ## todo: issue a warning here; no fixture type specified; assume country?
      end
      
    end # each arg
    
    puts 'Done.'
  end
end # command load


command :stats do |c|
  c.syntax = 'worlddb stats [options]'
  c.description = 'Show stats'
  c.action do |args, options|
    myopts.merge_commander_options!( options.__hash__ )
    connect_to_db( myopts ) 
    
    WorldDB.stats
    
    puts 'Done.'
  end
end


command :test do |c|
  c.syntax = 'worlddb test [options]'
  c.description = 'Debug/test command suite'
  c.action do |args, options|
    puts "hello from test command"
    puts "args (#{args.class.name}):"
    pp args
    puts "options:"
    pp options
    puts "options.__hash__:"
    pp options.__hash__
    puts 'Done.'
  end
end
