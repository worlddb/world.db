# worlddb

world.db Command Line Tool

* home  :: [github.com/worlddb/world.db](https://github.com/worlddb/world.db)
* bugs  :: [github.com/worlddb/world.db/issues](https://github.com/worlddb/world.db/issues)
* gem   :: [rubygems.org/gems/worlddb](https://rubygems.org/gems/worlddb)
* rdoc  :: [rubydoc.info/gems/worlddb](http://rubydoc.info/gems/worlddb)
* forum :: [groups.google.com/group/openmundi](https://groups.google.com/group/openmundi)


## Usage Command Line

The worlddb gem lets you load plain text fixtures into your database
(and also includes schema n models for easy reuse).

```
SYNOPSIS
    worlddb [global options] command [command options] [arguments...]

VERSION
    2.0

GLOBAL OPTIONS
    -d, --dbpath=PATH - Database path (default: .)
    -n, --dbname=NAME - Database name (default: world.db)
    --verbose         - (Debug) Show debug messages
    --version         - Show version

COMMANDS
    create        - Create DB schema
    setup, s      - Create DB schema 'n' load all world data
    update, up, u - Update all world data
    load, l       - Load world fixtures
    logs          - Show logs
    props         - Show props
    stats         - Show stats
    test          - (Debug) Test command suite
    help          - Shows a list of commands or help for one command
```


### `setup` Command

```
NAME
    setup - Create DB schema 'n' load all world data

SYNOPSIS
    worlddb [global options] setup [command options] NAME

COMMAND OPTIONS
    -i, --include=PATH  - World data path (default: .)

EXAMPLES
    worlddb setup --include ./world.db
    worlddb setup us --include ./world.db
```


### `update` Command

```
NAME
    update - Update all world data

SYNOPSIS
    worlddb [global options] update [command options] NAME

COMMAND OPTIONS
    --delete           - Delete all world data records
    -i, --include=PATH - World data path (default: .)

EXAMPLES
    worlddb update --include ./world.db
    worlddb update --include ./world.db --delete
```


### `load` Command

```
NAME
    load - Load world fixtures

SYNOPSIS
    worlddb [global options] load [command options] NAME

COMMAND OPTIONS
    --delete           - Delete all world data records
    -i, --include=PATH - World data path (default: .)

EXAMPLES
    worlddb load --include ./world.db europe/countries
```


## Install

Just install the gem:

    $ gem install worlddb



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `worlddb` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [Open Mundi (world.db) Database Forum/Mailing List](http://groups.google.com/group/openmundi).
Thanks!
