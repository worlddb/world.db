
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
class City < ActiveRecord::Base ; end

class StateBase < ActiveRecord::Base ; end
class State  < StateBase ; end  ## ADM1
class Part   < StateBase ; end  ## x   /ADM2
class County < StateBase ; end  ## ADM2/ADM3
class Muni   < StateBase ; end  ## ADM3/ADM4

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

State       = WorldDb::Model::State   ## ADM1
Part        = WorldDb::Model::Part    ## x   /ADM2
County      = WorldDb::Model::County  ## ADM2/ADM3
Muni        = WorldDb::Model::Muni    ## ADM3/ADM4

City        = WorldDb::Model::City

Lang        = WorldDb::Model::Lang
Usage       = WorldDb::Model::Usage

CountryCode = WorldDb::Model::CountryCode

  end
end
