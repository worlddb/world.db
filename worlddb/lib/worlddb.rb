# encoding: utf-8

require 'worlddb/models'   # NOTE: depends on core (aka worlddb-models)

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


WorldDb.main   if __FILE__ == $0
