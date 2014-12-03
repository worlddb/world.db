
## $:.unshift(File.dirname(__FILE__))

## minitest setup

# require 'minitest/unit'
require 'minitest/autorun'


# our own code

require 'worlddb'
require 'logutils/db'   # NB: explict require required for LogDb (not automatic) 


Name      = WorldDb::Model::Name
Place     = WorldDb::Model::Place
Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
Region    = WorldDb::Model::Region
City      = WorldDb::Model::City

Lang      = WorldDb::Model::Lang
Usage     = WorldDb::Model::Usage



WorldDb.setup_in_memory_db

