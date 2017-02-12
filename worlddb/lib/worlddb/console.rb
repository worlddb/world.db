# encoding: utf-8


## for use to run with interactive ruby (irb)
##  e.g.  irb -r worlddb/console

require 'logger'
require 'worlddb/models'


## shortcuts for models

Prop       = ConfDb::Model::Prop

Tag        = TagDb::Model::Tag
Tagging    = TagDb::Model::Tagging

Continent  = WorldDb::Model::Continent
Country    = WorldDb::Model::Country
Region     = WorldDb::Model::Region
City       = WorldDb::Model::City

## connect to db

DB_CONFIG = {
  adapter:  'sqlite3',
  database: './world.db'
}

pp DB_CONFIG
ActiveRecord::Base.establish_connection( DB_CONFIG )


## test drive

puts "Welcome to world.db, version #{WorldDb::VERSION}!"

WorldDb.tables

puts "Ready."

## some countries

## add some predefined shortcuts

##### some countries

# local variables (e.g. at) not working; use constants instead (e.g. AT)

AT = Country.find_by_key( 'at' )
DE = Country.find_by_key( 'de' )
EN = Country.find_by_key( 'en' )

GB = Country.find_by_key( 'gb' )
EU = Country.find_by_key( 'eu' )

US = Country.find_by_key( 'us' )
CA = Country.find_by_key( 'ca' )
MX = Country.find_by_key( 'mx' )

### some cities

NYC = City.find_by_key( 'newyork' )
LON = City.find_by_key( 'london' )
VIE = City.find_by_key( 'wien' )

## todo: add some predefined tags (e.g. europe, america, g8, euro, etc.)

EURO    = Tag.find_by_key( 'euro' )
EUROPE  = Tag.find_by_key( 'europe' )
ASIA    = Tag.find_by_key( 'asia' )
PACIFIC = Tag.find_by_key( 'pacific' )


## turn on activerecord logging to console

ActiveRecord::Base.logger = Logger.new( STDOUT )
