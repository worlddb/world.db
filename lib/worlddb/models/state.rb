# encoding: UTF-8

module WorldDb
  module Model


class State < StateBase

  has_many :cities, class_name: 'City', foreign_key: 'state_id'
  
  ## has_many :parts,     class_name: 'Part',   foreign_key: 'state_id'  ## substates
  ## has_many :counties,  class_name: 'County', foreign_key: 'state_id'  ## substates

  def place_kind   # use place_kind_of_code ??
    'ADM1'   # note: for now assumes always level 1
  end
  
  def state_id  # return top-level (e.g. adm1) state_id
    id
  end

end # class State



  end # module Model
end # module WorldDb
