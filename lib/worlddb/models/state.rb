# encoding: UTF-8

module WorldDb
  module Model


class State < StateBase

  belongs_to :country,  class_name: 'Country', foreign_key: 'country_id'

  has_many   :parts,    class_name: 'Part',    foreign_key: 'state_id'
  has_many   :counties, class_name: 'County',  foreign_key: 'state_id'
  has_many   :cities,   class_name: 'City',    foreign_key: 'state_id'

  def place_kind   # use place_kind_of_code ??
    'ADM1'   # note: for now assumes always level 1
  end
  
  def state_id  # return top-level (e.g. adm1) state_id
    id
  end

end # class State


class Part < StateBase    ## optional ADM2 e.g. Regierungsbezirke in Bayern, etc.

  belongs_to :state,     class_name: 'State',  foreign_key: 'state_id'

  has_many   :counties,  class_name: 'County', foreign_key: 'part_id'

  def place_kind   # use place_kind_of_code ??
    'ADM2'   # note: for now assumes always level 2
  end

end # class Part


class County < StateBase   ## note: might be ADM2 or ADM3

  belongs_to :state, class_name: 'State', foreign_key: 'state_id'
  belongs_to :part,  class_name: 'Part',  foreign_key: 'part_id'  ## optional assoc (used if level=3 and not 2)

  has_many   :munis, class_name: 'Muni',  foreign_key: 'county_id'

  def place_kind   # use place_kind_of_code ??
    "ADM#{level}"   # note: might be ADM2 or ADM3
  end

end # class County


class Muni < StateBase   ## note: might be ADM3 or ADM4

  belongs_to :county, class_name: 'County', foreign_key: 'county_id'

  has_many   :cities, class_name: 'City',   foreign_key: 'muni_id'

  def place_kind   # use place_kind_of_code ??
    "ADM#{level}"   # note: might be ADM3 or ADM4
  end

end # class Muni


  end # module Model
end # module WorldDb
