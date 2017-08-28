require 'hoe'
require './lib/worlddb/service/version.rb'


Hoe.spec 'worlddb-service' do
  
  self.version = WorldDB::Service::VERSION
  
  self.summary = 'worlddb plugin for web service/HTTP API (JSON/CSV/HTML)'
  self.description = summary

  self.urls    = ['https://github.com/geraldb/world.db.api']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'opensport@googlegroups.com'
    
  self.readme_file  = 'README.md'
  self.history_file = 'History.md'
  
  self.extra_deps = [
    ['sinatra', '~> 1.3.5']
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }
  
end