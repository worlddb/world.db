require 'pp'
require 'hoe'
require './lib/worlddb/version.rb'

## NB: plugin (hoe-manifest) not required; just used for future testing/development
Hoe::plugin :manifest   # more options for manifests (in the future; not yet)


###########
#### NB: if you try this script at home
#    you need to create a (symbolic) link to the world.db fixtures
#     e.g. use ln -s ../world.db  data  or similar


Hoe.spec 'worlddb' do
  
  self.version = WorldDB::VERSION
  
  self.summary = "worlddb - world.db command line tool"
  self.description = summary

  self.urls    = ['https://github.com/geraldb/world.db.ruby']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'opensport@googlegroups.com'
  
  self.extra_deps = [
    ['activerecord', '~> 3.2']  # NB: will include activesupport,etc.
    ### ['sqlite3',      '~> 1.3']  # NB: install on your own; remove dependency
  ]
  
  self.licenses = ['Public Domain']

  self.spec_extras = {
    :required_ruby_version => '>= 1.9.2'
  }

end

##############################
## for testing 
##
## NB: use rake -I ./lib dev:test      # fresh import (starts w/ clean wipe out)

namespace :dev do
  
  BUILD_DIR = "./build"
  
  WORLD_DB_PATH = "#{BUILD_DIR}/world.db"

  DB_CONFIG = {
    :adapter   =>  'sqlite3',
    :database  =>  WORLD_DB_PATH
  }

  directory BUILD_DIR

  task :clean do
    rm WORLD_DB_PATH if File.exists?( WORLD_DB_PATH )
  end

  task :env => BUILD_DIR do
    require './lib/worlddb.rb'

    pp DB_CONFIG
    ActiveRecord::Base.establish_connection( DB_CONFIG )
  end

  task :create => :env do
    WorldDB.create
  end
  
  task :import => :env do
    WorldDB.read_all  # populate world tables
    WorldDB.stats
  end


  desc 'worlddb - test loading of builtin fixtures'
  task :test => [:clean, :create, :import]

  desc 'worlddb - test loading of builtin fixtures (update)'
  task :update => [:import]

end  # namespace :dev
