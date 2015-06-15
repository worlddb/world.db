# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_state_tree_reader_name_finder.rb


require 'helper'

class TestStateTreeReaderNameFinder < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end
  
  def test_at
    at = Country.create!( key: 'at',
                     name: 'Austria',
                     code: 'AUT',
                     pop: 0,
                     area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/at-austria" )
    reader.load_setup( 'setups/adm' )

    n = State.find_by!( key: 'n' )


    ## find counties w/ state_id using names 
    names = Name.joins( :place => :county ).where(
                                              :name                => 'Horn',
                                              :place_kind          => 'COUN',
                                              :'counties.state_id' => n.id )
    ## results in:
    ## SELECT "names".* FROM "names"
    ##   INNER JOIN "places" ON "places"."id" = "names"."place_id"
    ##   INNER JOIN "counties" ON "counties"."place_id" = "places"."id"
    ##   WHERE "names"."name" = ?
    ##     AND "names"."place_kind" = ?
    ##     AND "counties"."state_id" = 2
    ## [["name", "Horn"], ["place_kind", "COUN"]]

    pp names


    ## find munies w/ state_id using names 
    names = Name.joins( :place => :muni ).where(
                                                :name             => 'Horn',
                                                :place_kind       => 'MUNI',
                                                :'munis.state_id' => n.id )

    ## results in:
    ## SELECT "names".* FROM "names"
    ##   INNER JOIN "places" ON "places"."id" = "names"."place_id"
    ##   INNER JOIN "munis" ON "munis"."place_id" = "places"."id"
    ##   WHERE "names"."name" = ?
    ##     AND "names"."place_kind" = ?
    ##     AND "munis"."state_id" = 2
    ##  [["name", "Horn"], ["place_kind", "MUNI"]]

    pp names

  end

end # class TestStateTreeReaderNameFinder

