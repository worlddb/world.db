# encoding: utf-8

module WorldDb
  module Model

class Place < ActiveRecord::Base

  ## todo: depending on type
  ##  has_one continent, country, state, city etc.
  has_one :state,  class_name: 'State',  foreign_key: 'place_id'
  has_one :county, class_name: 'County', foreign_key: 'place_id'
  has_one :muni,   class_name: 'Muni',   foreign_key: 'place_id'
  ## add more types..

end  # class Place


  end # module Model
end # module WorldDb

