# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_report_country.rb


require 'helper'

class TestReportCountry < MiniTest::Test

  ## note: special tests
  ##   run on its own - will NOT run with test suite
  ##   requires its own connection

  def xxx_test_at

    ## connect to ./austria.db
    WorldDb.connect( adapter: 'sqlite3', database: './austria.db' )

    r = WorldDb::CountryReport.new( 'at' )
    r.report
  end

  def xxx_test_de
    ## connect to ./deutschland.db
    WorldDb.connect( adapter: 'sqlite3', database: './deutschland.db' )

    r = WorldDb::CountryReport.new( 'de' )
    r.report
  end


end # class TestReportCountry
