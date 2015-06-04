# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_model_states.rb


require 'helper'

class TestModelStates < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end


  def test_de   # country > state > part > county > muni

    de = Country.create!( key: 'de',
                          name: 'Deutschland',
                          code: 'DEU',
                          pop: 1,
                          area: 1 )

    by = State.create!(  key:  'by',
                         name: 'Bayern',
                         country_id: de.id,
                         pop: 1,
                         area: 1 )

    by2 = State.find_by_key!( 'by' )
    assert_equal by.id, by2.id

    assert_equal 'Bayern',   by.name 
    assert_equal 1,          by.area 
    assert_equal de.id,      by.country_id
    assert_equal 1,          by.level
    assert_equal 'ADM1',     by.place_kind

    ### test place
    assert_equal  'Bayern', by.place.name

    ## test assocs
    assert_equal  'Deutschland', by.country.name
    assert_equal  0,             by.parts.count
    assert_equal  0,             by.counties.count

    ############
    # Part

    ob = Part.create!( key: 'ob',
                       name: 'Oberbayern',
                       state_id: by.id,
                       pop: 1,
                       area: 1 )

    ob2 = Part.find_by_key!( 'ob' )
    assert_equal ob.id, ob2.id

    assert_equal 'Oberbayern',   ob.name 
    assert_equal 1,              ob.area 
    assert_equal by.id,          ob.state_id
    assert_equal 2,              ob.level
    assert_equal 'ADM2',         ob.place_kind

    ### test place
    assert_equal  'Oberbayern', ob.place.name

    ## test assocs
    assert_equal  'Bayern',      ob.state.name
    assert_equal  0,             ob.counties.count
    assert_equal  1,             by.parts.count
    assert_equal  'Oberbayern',  by.parts.first.name

    #############################
    # County (Landkreis, Bezirk, etc.)

    fs = County.create!( key: 'fs',
                         name: 'Freising',
                         state_id: by.id,
                         part_id: ob.id,
                         pop: 1,
                         area: 1,
                         level: 3 )

    fs2 = County.find_by_key!( 'fs' )
    assert_equal fs.id, fs2.id

    assert_equal 'Freising',  fs.name 
    assert_equal 1,           fs.area 
    assert_equal by.id,       fs.state_id
    assert_equal ob.id,       fs.part_id
    assert_equal 3,           fs.level
    assert_equal 'ADM3',      fs.place_kind

    ### test place
    assert_equal  'Freising', fs.place.name

    ## test assocs
    assert_equal  'Bayern',      fs.state.name
    assert_equal  'Oberbayern',  fs.part.name
    assert_equal  0,             fs.munis.count
    assert_equal  1,             by.counties.count
    assert_equal  1,             ob.counties.count
    assert_equal  'Freising',    by.counties.first.name
    assert_equal  'Freising',    ob.counties.first.name

  end

end # class TestModelStates
