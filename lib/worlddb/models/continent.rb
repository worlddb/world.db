# encoding: utf-8

module WorldDb
  module Model

class Continent < ActiveRecord::Base

  belongs_to :place,     class_name: 'Place',   foreign_key: 'place_id'
  has_many   :countries

  ## begin compat
  def title()       name;              end
  def title=(value) self.name = value; end

  def synonyms()       alt_names;              end
  def synonyms=(value) self.alt_names = value; end
  ## end


  # NB: allow dots in keys e.g. concacaf.naf etc.    

  before_create :on_create
  before_update :on_update

  def on_create
    place_rec = Place.create!( name: name, kind: place_kind )
    self.place_id = place_rec.id 

    self.slug = TextUtils.slugify( name )  if slug.blank?
  end

  def on_update
    ## fix/todo: check - if name or kind changed - only update if changed ?? why? why not??
    place.update_attributes!( name: name, kind: place_kind )
    
    ## check if name changed -- possible?
    ## update slug too??
  end

  def place_kind   # use place_kind_of_code ??
    'CONT'
  end


end  # class Continent


  end # module Model
end # module WorldDb

