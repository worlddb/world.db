# encoding: utf-8

require 'worlddb/models'   # Note: depends on core (aka worlddb-models)

require 'webservice'

require 'fetcher'
require 'datafile'

require 'gli'

# our own code

require 'worlddb/cli/version'   # version always goes first

require 'worlddb/cli/opts'
require 'worlddb/cli/main'


module WorldDb

  def self.main
    exit Tool.new.run(ARGV)
  end

end  # module WorldDb



####
##  used for server/service command
##   "preconfigured" base class for webservice
class WorldDbService < Webservice::Base
  include WorldDb::Models   # e.g. Continent, Country, State, City, etc.

  ## (auto-)add some (built-in) routes

  get '/version(s)?' do
    {
      "worlddb":        WorldDbTool::VERSION,
      "worlddb/models": WorldDb::VERSION,
      ## todo/fix: add some more libs - why? why not??
      "activerecord":  [ActiveRecord::VERSION::MAJOR,ActiveRecord::VERSION::MINOR,ActiveRecord::VERSION::TINY].join('.'),
      "webservice":    Webservice::VERSION,
      "rack":          "#{Rack::RELEASE} (#{Rack::VERSION.join('.')})",     ## note: VERSION is the protocoll version as an array e.g.[1,2]
      "ruby":          "#{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]",
    }
  end

  get '/(stats|tables)' do
    {
      "countries":      WorldDb::Model::Country.count,
      "states":         WorldDb::Model::State.count,
      "cities":         WorldDb::Model::City.count,
      "system": {
        "props":    ConfDb::Models::Prop.count,
        "logs":     LogDb::Models::Log.count,
      }
    }
  end

  get '/props(.:format)?' do    # note: add format - lets you use props.csv and props.html
    ConfDb::Models::Prop.all
  end

  get '/logs(.:format)?' do
    LogDb::Models::Log.all
  end


  ## add favicon support
  get '/favicon.ico' do
    ## use 302 to redirect
    ##  note: use strg+F5 to refresh page (clear cache for favicon.ico)
    redirect '/webservice-worlddb-32x32.png'
  end

  get '/webservice-worlddb-32x32.png' do
    send_file "#{WorldDbTool.root}/assets/webservice-worlddb-32x32.png"
  end

end # class WorldDbService



WorldDb.main   if __FILE__ == $0
