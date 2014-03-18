# encoding: utf-8

module WorldDb
  module Model

#############################################################
# collect depreciated or methods for future removal here
#  - keep for now for commpatibility (for old code)

class City

  #####################################################
  # alias for name (remove! add depreciated api call ???)
  def title()       name;              end
  def title=(value) self.name = value; end

  scope :by_title, ->{ order( 'name asc' ) } # order by title (a-z)

end # class Cities

  end # module Model
end # module WorldDb

