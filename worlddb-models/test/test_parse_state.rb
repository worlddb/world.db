# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_parse_state.rb


require 'helper'

class TestParseState < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end

  def test_at

    at = Country.parse( 'at',
                        'Austria',
                        'AUT',
                        '8_414_638 km²',
                        '83_871' )

    w = State.parse( 'w',
                     'Wien',
                     '415 km²',
                     'eastern austria',
                     country_id: at.id )

    w2 = State.find_by!( key: 'w' )
    assert_equal w.id, w2.id

    assert_equal 'Wien',  w.name 
    assert_equal 415,     w.area 
    assert_equal at.id,   w.country_id

    ### test place
    assert_equal  'Wien', w.place.name

    ## test assocs
    assert_equal  'Austria', w.country.name
  end

end # class TestParseState

