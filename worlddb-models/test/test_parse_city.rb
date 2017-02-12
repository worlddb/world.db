# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_parse_city.rb

require 'helper'

class TestParseCity < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end


  def test_at

    at = Country.parse( 'at',
                        'Austria',
                        'AUT',
                        '83_871 km²',
                        '8_414_638' )

    w = State.parse( 'w',
                     'Wien',
                     country_id: at.id )

    c = City.parse( 'wien',
                    'Wien',
                    'W', 
                    '1_731_236',
                    'm:1_724_000',
                    country_id: at.id )

    c2 = City.find_by!( key: 'wien' )
    assert_equal c2.id, c.id

    assert_equal 'Wien',    c.name
    assert_equal 1_731_236, c.pop
    assert_equal w.id,      c.state_id
    assert_equal at.id,     c.country_id

    ### test place
    assert_equal  'Wien', c.place.name

    ## test assocs
    assert_equal  'Wien',    c.state.name
    assert_equal  'Austria', c.state.country.name
    assert_equal  'Austria', c.country.name


    #####
    # check (auto-)added metro record

    m = Metro.find_by!( key: 'wien' )
    assert_equal 'Wien',     m.name
    assert_equal 1_724_000,  m.pop
    assert_equal at.id,      m.country_id
    
    ## test assocs
    assert_equal  1,         m.cities.count
    assert_equal  'Wien',    m.cities.first.name
    assert_equal  'Austria', m.country.name

    assert_equal  'Wien',    c.metro.name
    assert_equal  m.id,      c.metro.id
  end

end # class TestParseCity
