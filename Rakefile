require 'hoe'
require './lib/worlddb/version.rb'


Hoe.spec 'worlddb' do
  
  self.version = WorldDb::VERSION
  
  self.summary = "worlddb - world.db command line tool"
  self.description = summary

  self.urls    = ['https://github.com/geraldb/world.db.ruby']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'openmundi@googlegroups.com'

  self.extra_deps = [
    ['props'],         # settings / prop(ertie)s / env / INI
    ['logutils'],     # logging
    ['textutils', '>= 0.9.4'], # e.g.  >= 0.6 && <= 1.0  ## will include logutils, props
    ['tagutils'],     # tags n categories for activerecord

     ## 3rd party
    ['gli', '>= 2.9'],
    ['activerecord']  # NB: will include activesupport,etc.
    ### ['sqlite3',      '~> 1.3']  # NB: install on your own; remove dependency
  ]

  # switch extension to .markdown for gihub formatting
  #  -- NB: auto-changed when included in manifest
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'


  self.licenses = ['Public Domain']

  self.spec_extras = {
    :required_ruby_version => '>= 1.9.2'
  }

end
