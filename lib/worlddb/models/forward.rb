
### forward references
##   require first to resolve circular references

module WorldDb
  module Model

#############
# ConfDb
Prop      = ConfDb::Model::Prop

###########
# TagDb
Tagging   = TagDb::Model::Tagging
Tag       = TagDb::Model::Tag


class Name < ActiveRecord::Base ; end
class Place < ActiveRecord::Base ; end
class Continent < ActiveRecord::Base ; end
class Country < ActiveRecord::Base ; end
class State < ActiveRecord::Base ; end
class City < ActiveRecord::Base ; end

class Lang < ActiveRecord::Base ; end
class Usage < ActiveRecord::Base ; end

class CountryCode < ActiveRecord::Base ; end

  end

  # note: convenience alias for Model
  # lets you use include WorldDb::Models
  Models = Model   
end # module # WorldDb


module TagDb
  module Model

# add alias? why? why not? # is there a better way?
#  - just include WorldDb::Models  - why? why not?

Name        = WorldDb::Model::Name
Place       = WorldDb::Model::Place
Continent   = WorldDb::Model::Continent
Country     = WorldDb::Model::Country
State       = WorldDb::Model::State
City        = WorldDb::Model::City

Lang        = WorldDb::Model::Lang
Usage       = WorldDb::Model::Usage

CountryCode = WorldDb::Model::CountryCode

  end
end
