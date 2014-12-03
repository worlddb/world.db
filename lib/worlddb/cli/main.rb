# encoding: utf-8

require 'gli'
 
include GLI::App

# our own code / additional for cli only

require 'logutils/db'     # add support for logging to db
require 'worlddb/cli/opts'


program_desc 'world.db command line tool'

version WorldDb::VERSION


LogUtils::Logger.root.level = :info   # set logging level to info 
logger = LogUtils::Logger.root

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
opts = WorldDb::Opts.new


### global option (required)
## todo: add check that path is valid?? possible?

desc 'Database path'
arg_name 'PATH'
default_value opts.db_path
flag [:d, :dbpath]

desc 'Database name'
arg_name 'NAME'
default_value opts.db_name
flag [:n, :dbname]

desc '(Debug) Show debug messages'
switch [:verbose], negatable: false ## todo: use -w for short form? check ruby interpreter if in use too?

desc 'Only show warnings, errors and fatal messages'
switch [:q, :quiet], negatable: false



def connect_to_db( options )
  puts WorldDb.banner

  puts "working directory: #{Dir.pwd}"

  WorldDb.connect( adapter:  'sqlite3',
                   database: "#{options.db_path}/#{options.db_name}" )

  LogDb.setup  # turn on logging to db (that is, log to logs table in db)
end


desc 'Create DB schema'
command [:create] do |c|
  c.action do |g,o,args|
    
    connect_to_db( opts )
    
    WorldDb.create_all

    puts 'Done.'
  end # action
end # command create


desc "Create DB schema 'n' load all world data"
arg_name 'NAME' # optional setup profile name
command [:setup,:s] do |c|

  c.desc 'World data path'
  c.arg_name 'PATH'
  c.default_value opts.data_path
  c.flag [:i,:include]

  c.action do |g,o,args|

    connect_to_db( opts )
 
    ## todo: document optional setup profile arg (defaults to all)
    setup = args[0] || 'all'
    
    WorldDb.create_all

    WorldDb.read_setup( "setups/#{setup}", opts.data_path )

    puts 'Done.'
  end # action
end # command setup

desc 'Update all world data'
arg_name 'NAME' # optional setup profile name
command [:update,:up,:u] do |c|

  c.desc 'World data path'
  c.arg_name 'PATH'
  c.default_value opts.data_path
  c.flag [:i,:include]

  c.desc 'Delete all world data records'
  c.switch [:delete], negatable: false

  c.action do |g,o,args|

    connect_to_db( opts )

    ## todo: document optional setup profile arg (defaults to all)
    setup = args[0] || 'all'

    if o[:delete].present?
      ## todo/fix: also delete TagDb.delete!
      WorldDb.delete!
    end

    WorldDb.read_setup( "setups/#{setup}", opts.data_path )

    puts 'Done.'
  end # action
end # command setup



desc 'Load world fixtures'
arg_name 'NAME' # multiple fixture names - todo/fix: use multiple option
command [:load, :l] do |c|

  c.desc 'Delete all world data records'
  c.switch [:delete], negatable: false

  c.action do |g,o,args|

    connect_to_db( opts )
    
    if o[:delete].present?
      ## todo/fix: also delete TagDb.delete!
      WorldDb.delete!
    end

    reader = WorldDb::Reader.new( opts.data_path )

    args.each do |arg|
      name = arg # File.basename( arg, '.*' )
      reader.load( name )
    end # each arg

    puts 'Done.'
  end
end # command load


desc 'Show stats'
command :stats do |c|
  c.action do |g,o,args|

    connect_to_db( opts )

    WorldDb.tables
    TagDb.tables

    puts 'Done.'
  end
end


desc 'Show props'
command :props do |c|
  c.action do |g,o,args|

    connect_to_db( opts )
    
    ### fix: use ConfDb.dump or similar  (for reuse) !!!
    ## WorldDb.props

    puts 'Done.'
  end
end


desc 'Show logs'
command :logs do |c|
  c.action do |g,o,args|

    connect_to_db( opts )

    ### fix: use LogDb.dump or similar (for reuse) !!!!    
    LogDb::Models::Log.all.each do |log|
      puts "[#{log.level}] -- #{log.msg}"
    end
    
    puts 'Done.'
  end
end


desc '(Debug) Test command suite'
command :test do |c|
  c.action do |g,o,args|

    puts "hello from test command"
    puts "args (#{args.class.name}):"
    pp args
    puts "o (#{o.class.name}):"
    pp o
    puts "g (#{g.class.name}):"
    pp g
    
    LogUtils::Logger.root.debug 'test debug msg'
    LogUtils::Logger.root.info 'test info msg'
    LogUtils::Logger.root.warn 'test warn msg'
    
    puts 'Done.'
  end
end


pre do |g,c,o,args|
  opts.merge_gli_options!( g )
  opts.merge_gli_options!( o )

  puts WorldDb.banner

  if opts.verbose?
    LogUtils::Logger.root.level = :debug
  end

  logger.debug "Executing #{c.name}"
  true
end

post do |global,c,o,args|
  logger.debug "Executed #{c.name}"
  true
end


on_error do |e|
  puts
  puts "*** error: #{e.message}"

  if opts.verbose?
    puts e.backtrace
  end

  false # skip default error handling
end


exit run(ARGV)
