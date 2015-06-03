# encoding: utf-8

module WorldDb
  module Model

#############################################################
# collect depreciated or methods for future removal here
#  - keep for now for commpatibility (for old code)


class Country

  def title()       name;              end
  def title=(value) self.name = value; end

  scope :by_title, ->{ order( 'name asc' ) }   # order by title (a-z)

  def iso2()       alpha2;              end
  def iso2=(value) self.alpha2 = value; end

  def iso3()       alpha3;              end
  def iso3=(value) self.alpha3 = value; end


  def synonyms()       alt_names;      end
  def synonyms=(value) self.alt_names = value; end

  def title_w_synonyms( opts={} )  all_names( opts );  end    # depreciated: use all_names instead

  has_many :regions, class_name: 'State', foreign_key: 'state_id'

end # class Country

  end # module Model
end # module WorldDb

