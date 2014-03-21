# encoding: utf-8

module WorldDb
  module Model

class Continent < ActiveRecord::Base

  belongs_to :place,     class_name: 'Place',   foreign_key: 'place_id'
  has_many   :countries

  # NB: allow dots in keys e.g. concacaf.naf etc.    

  before_create :on_create
  before_update :on_update

  def on_create
    place_rec = Place.create!( name: name, kind: place_kind )
    self.place_id = place_rec.id 
  end

  def on_update
    ## fix/todo: check - if name or kind changed - only update if changed ?? why? why not??
    place.update_attributes!( name: name, kind: place_kind )
  end

  def place_kind   # use place_kind_of_code ??
    'CONT'
  end


end  # class Continent


  end # module Model
end # module WorldDb

