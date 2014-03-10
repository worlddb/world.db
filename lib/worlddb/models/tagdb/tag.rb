# encoding: utf-8

module TagDb
  module Model

class Tag

  has_many :cities,    :through => :taggings, :source => :taggable, :source_type: 'WorldDb::Model::City',    class_name: 'WorldDb::Model::City'
  has_many :countries, :through => :taggings, :source => :taggable, :source_type: 'WorldDb::Model::Country', class_name: 'WorldDb::Model::Country'
  has_many :regions,   :through => :taggings, :source => :taggable, :source_type: 'WorldDb::Model::Region',  class_name: 'WorldDb::Model::Region'

end  # class Tag

  end # module Model
end # module WorldDb

