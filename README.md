# worlddb

world.db Command Line Tool in Ruby

* home  :: [github.com/geraldb/world.db.ruby](https://github.com/geraldb/world.db.ruby)
* bugs  :: [github.com/geraldb/world.db.ruby/issues](https://github.com/geraldb/world.db.ruby/issues)
* gem   :: [rubygems.org/gems/worlddb](https://rubygems.org/gems/worlddb)
* rdoc  :: [rubydoc.info/gems/wrolddb](http://rubydoc.info/gems/worlddb)
* forum :: [groups.google.com/group/openmundi](https://groups.google.com/group/openmundi)


## Usage Command Line

    world.db command line tool, version 2.0.0
    
    Commands:
      create               Create DB schema
      help                 Display global or [command] help documentation.
      load                 Load fixtures
      logs                 Show logs
      props                Show props
      setup                Create DB schema 'n' load all data
      stats                Show stats
      test                 Debug/test command suite
    
    Global Options:
      -i, --include PATH   Data path (default is .)
      -d, --dbpath PATH    Database path (default is .)
      -n, --dbname NAME    Database name (datault is world.db)
      -q, --quiet          Only show warnings, errors and fatal messages
      -w, --verbose        Show debug messages
      -h, --help           Display help documentation
      -v, --version        Display version information
      -t, --trace          Display backtrace when an error occurs



## Usage Models

`Country` Model - Example:

    at = Country.find_by! key: 'at'
    at.name
    # => 'Austria'
    at.pop
    # => 8_414_638
    at.area
    # => 83_871
    
    at.regions.count
    # => 9
    at.regions
    # => [ 'Wien', 'Niederösterreich', 'Oberösterreich', ... ]

    at.cities.by_pop
    # => [ 'Wien', 'Graz', 'Linz', 'Salzburg', ... ]


'City' Model - Example:

    c = City.find_by! key: 'wien'
    c.name
    # => 'Wien'
    c.country.name
    # => 'Austria'
    c.country.continent.name
    # => 'Europe'

    la = City.find_by! key: 'losangeles'
    la.name
    # => 'Los Angeles'
    la.region.name
    # => 'California'
    la.region.key
    # => 'ca'
    la.country.name
    # => 'United States'
    la.country.key
    # => 'us'
    la.country.continent.name
    # => 'North America'


'Tag' Model - Example:

    euro = Tag.find_by! key: 'euro'
    euro.countries.count
    # => 17
    euro.countries
    # => ['Austria, 'Belgium', 'Cyprus', ... ]
    
    flanders = Tag.find_by! key: 'flanders'
    flanders.regions.count
    # => 5
    flanders.regions
    # => ['Antwerpen', 'Brabant Wallon', 'Limburg', 'Oost-Vlaanderen', ... ]
    flanders.regions.first.country.name
    # => 'Belgium'

and so on.


## Install

Just install the gem:

    $ gem install worlddb


## Free Open Public Domain Datasets

- [`world.db`](https://github.com/openmundi) - free open public domain countries, regions, cities n more data for use in any (programming) language


## License

The `worlddb` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [Open Mundi (world.db) Database Forum/Mailing List](http://groups.google.com/group/openmundi).
Thanks!

