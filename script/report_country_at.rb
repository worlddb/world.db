# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./script script/report_country_at.rb


require 'worlddb/models'


## connect to ./austria.db
WorldDb.connect( adapter: 'sqlite3', database: './austria.db' )

r = WorldDb::CountryReport.new( 'at' )
r.report

