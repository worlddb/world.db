# encoding: utf-8

module WorldDb
  module Model

class Continent < ActiveRecord::Base

  belongs_to :place,     class_name: 'Place',   foreign_key: 'place_id'
  has_many   :countries

  # NB: allow dots in keys e.g. concacaf.naf etc.    

end  # class Continent


  end # module Model
end # module WorldDb

