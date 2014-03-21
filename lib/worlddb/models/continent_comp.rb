# encoding: utf-8

module WorldDb
  module Model

#############################################################
# collect depreciated or methods for future removal here
#  - keep for now for commpatibility (for old code)

class Continent

  def title()       name;              end
  def title=(value) self.name = value; end

  scope :by_title, ->{ order( 'name asc' ) } # order by title (a-z)

  def synonyms()       alt_names;      end
  def synonyms=(value) self.alt_names = value; end

end # class Continent


  end # module Model
end # module WorldDb
