# encoding: utf-8

module WorldDb
  module Model


class City < CityBase

  self.table_name = 'cities'

  belongs_to :country,   class_name: 'Country',  foreign_key: 'country_id'
  belongs_to :state,     class_name: 'State',    foreign_key: 'state_id'
  belongs_to :muni,      class_name: 'Muni',     foreign_key: 'muni_id'

  belongs_to :metro,     class_name: 'Metro',    foreign_key: 'metro_id'
  has_many   :districts, class_name: 'District', foreign_key: 'city_id'

  def place_kind   # use place_kind_of_code ??
    'CITY'
  end


  def as_tab( opts={} )
    CitySerializer.new( self ).as_tab
  end

end # class City


class Metro < CityBase

  belongs_to :country, class_name: 'Country', foreign_key: 'country_id'
  ## note: metro might be part of more than one (two,three) states (thus, cannot belong_to state)
  ##   collect (all) states from cities??

  has_many   :cities, class_name: 'City',  foreign_key: 'metro_id'

  def place_kind   # use place_kind_of_code ??
    'MTRO'
  end

end # class Metro


class District < CityBase

  belongs_to :city,  class_name: 'City',    foreign_key: 'city_id'

  def place_kind   # use place_kind_of_code ??
    'DIST'
  end

end # class District


  end # module Model
end # module WorldDb
