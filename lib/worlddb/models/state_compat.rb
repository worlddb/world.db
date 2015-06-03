# encoding: utf-8

module WorldDb
  module Model

#############################################################
# collect depreciated or methods for future removal here
#  - keep for now for commpatibility (for old code)

class State

  def title()       name;              end
  def title=(value) self.name = value; end

  scope :by_title, ->{ order( 'name asc' ) } # order by title (a-z)

  def synonyms()       alt_names;      end
  def synonyms=(value) self.alt_names = value; end

  def title_w_synonyms( opts={} )  all_names( opts );  end    # depreciated: use all_names instead

  has_many  :regions, class_name: 'State', foreign_key: 'state_id'   ## subregions

end # class State

### add "old" alias for State class
Region = State

  end # module Model
end # module WorldDb
