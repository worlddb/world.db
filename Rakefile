require 'hoe'
require './lib/worlddb/version.rb'


Hoe.spec 'worlddb-models' do

  self.version = WorldDb::VERSION

  self.summary = "worlddb -  world.db schema 'n' models for easy (re)use"
  self.description = summary

  self.urls    = ['https://github.com/worlddb/world.db.models']

  self.author  = 'Gerald Bauer'
  self.email   = 'openmundi@googlegroups.com'

  self.extra_deps = [
    ['props',     '>= 1.1.2'],         # settings / prop(ertie)s / env / INI
    ['logutils',  '>= 0.6.1'],     # logging
    ['textutils', '>= 0.10.0'], 

    ['tagutils',              '>= 0.3.0'],  # tags n categories for activerecord
    ['activerecord-utils',    '>= 0.2.0'],
    ['props-activerecord',    '>= 0.1.0'],
    ['logutils-activerecord', '>= 0.2.0'],

     ## 3rd party
    ['rubyzip'],       ## todo: pull in via textutils ??
    ['activerecord']  # NB: will include activesupport,etc.
  ]

  # switch extension to .markdown for gihub formatting
  #  -- NB: auto-changed when included in manifest
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'


  self.licenses = ['Public Domain']

  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end
