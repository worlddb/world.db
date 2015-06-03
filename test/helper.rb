
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
City      = WorldDb::Model::City

Lang      = WorldDb::Model::Lang
Usage     = WorldDb::Model::Usage



WorldDb.setup_in_memory_db

