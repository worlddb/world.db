
## $:.unshift(File.dirname(__FILE__))

## minitest setup
require 'minitest/autorun'


# our own code

require 'worlddb/models'


Name      = WorldDb::Model::Name
Place     = WorldDb::Model::Place
Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country

State     = WorldDb::Model::State
Part      = WorldDb::Model::Part
County    = WorldDb::Model::County
Muni      = WorldDb::Model::Muni

Metro     = WorldDb::Model::Metro
City      = WorldDb::Model::City
District  = WorldDb::Model::District

Lang      = WorldDb::Model::Lang
Usage     = WorldDb::Model::Usage



WorldDb.setup_in_memory_db

