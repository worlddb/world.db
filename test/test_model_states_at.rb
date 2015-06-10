# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_model_states_at.rb


require 'helper'

class TestModelStatesAt < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end


  def test_n   # country > state > county > muni

    at = Country.create!( key: 'at',
                          name: 'Austria',
                          code: 'AUT',
                          pop: 1,
                          area: 1 )

    n = State.create!( key:  'n',
                         name: 'Niederösterreich',
                         country_id: at.id,
                         pop: 1,
                         area: 1 )

    n2 = State.find_by_key!( 'n' )
    assert_equal n.id, n2.id

    assert_equal 'Niederösterreich', n.name 
    assert_equal 1,          n.area 
    assert_equal at.id,      n.country_id
    assert_equal 1,          n.level
    assert_equal 'STAT',     n.place_kind

    ### test place
    assert_equal  'Niederösterreich', n.place.name

    ## test assocs
    assert_equal  'Austria',     n.country.name
    assert_equal  0,             n.parts.count
    assert_equal  0,             n.counties.count
    assert_equal  0,             n.munis.count
    assert_equal  0,             n.cities.count

    #############################
    # County (Landkreis, Bezirk, etc.)

    tu = County.create!( key: 'tu',
                         name: 'Tulln',
                         state_id: n.id,
                         pop: 1,
                         area: 1 )

    tu2 = County.find_by_key!( 'tu' )
    assert_equal tu.id, tu2.id

    assert_equal 'Tulln',  tu.name 
    assert_equal 1,        tu.area 
    assert_equal n.id,     tu.state_id
    assert_equal 2,        tu.level
    assert_equal 'COUN',   tu.place_kind

    ### test place
    assert_equal  'Tulln', tu.place.name

    ## test assocs
    assert_equal  'Niederösterreich', tu.state.name
    assert_equal  0,             tu.munis.count
    assert_equal  0,             tu.cities.count
    assert_equal  1,             n.counties.count
    assert_equal  'Tulln',    n.counties.first.name

    #############################
    # Muni (Gemeinde - Markt, Stadt, etc.)

    gr = Muni.create!( key: 'grafenwoerth',
                       name: 'Grafenwörth',
                       state_id: n.id,
                       county_id: tu.id,
                       pop: 1,
                       area: 1 )

    gr2 = Muni.find_by_key!( 'grafenwoerth' )
    assert_equal gr.id, gr2.id

    assert_equal 'Grafenwörth', gr.name 
    assert_equal 1,             gr.area 
    assert_equal n.id,          gr.state_id
    assert_equal tu.id,         gr.county_id
    assert_equal 3,             gr.level
    assert_equal 'MUNI',        gr.place_kind

    ### test place
    assert_equal  'Grafenwörth', gr.place.name

    ## test assocs
    assert_equal  'Niederösterreich',  gr.county.state.name
    assert_equal  0,                   gr.cities.count
    assert_equal  1,                   n.munis.count
    assert_equal  1,                   tu.munis.count
    assert_equal  'Grafenwörth', n.munis.first.name
    assert_equal  'Grafenwörth', tu.munis.first.name
  end

end # class TestModelStatesAt
