# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./script script/report_country_de.rb


require 'worlddb/models'


## connect to ./austria.db
WorldDb.connect( adapter: 'sqlite3', database: './deutschland.db' )

r = WorldDb::CountryReport.new( 'de' )
r.report

