# encoding: utf-8

module WorldDb::Models

  class Continent < ActiveRecord::Base
    
    has_many :countries

    # NB: allow dots in keys e.g. concacaf.naf etc.    
    
  end  # class Continent

end # module WorldDb::Models
