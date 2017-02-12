# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_name_finders.rb


require 'helper'

class TestNameFinders < MiniTest::Test

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

    recs = Name.find_states( 'Wien', at.id )
    pp recs
    
    recs = Name.find_cities( 'Krems', at.id )
    pp recs


    ####
    # -- finders scoped by state

    n = State.find_by!( key: 'n' )

    recs = Name.find_parts( 'Waldviertel', n.id )
    pp recs

    ## find counties w/ state_id using names 
    recs = Name.find_counties( 'Horn', n.id )
    pp recs
    
    ## results in:
    ## SELECT "names".* FROM "names"
    ##   INNER JOIN "places" ON "places"."id" = "names"."place_id"
    ##   INNER JOIN "counties" ON "counties"."place_id" = "places"."id"
    ##   WHERE "names"."name" = ?
    ##     AND "names"."place_kind" = ?
    ##     AND "counties"."state_id" = 2
    ## [["name", "Horn"], ["place_kind", "COUN"]]



    ## find munis w/ state_id using names 
    recs = Name.find_munis( 'Horn', n.id )
    pp recs

    ## results in:
    ## SELECT "names".* FROM "names"
    ##   INNER JOIN "places" ON "places"."id" = "names"."place_id"
    ##   INNER JOIN "munis" ON "munis"."place_id" = "places"."id"
    ##   WHERE "names"."name" = ?
    ##     AND "names"."place_kind" = ?
    ##     AND "munis"."state_id" = 2
    ##  [["name", "Horn"], ["place_kind", "MUNI"]]

  end

end # class TestNameFinders

