# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_parse_country.rb


require 'helper'

class TestParseCountry < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end

  def test_to_path
    eu = Continent.create!( key: 'eu', name: 'Europe' )

    assert_equal 'europe', eu.slug

    at = Country.parse( 'at',
                        'Austria',
                        'AUT',
                        '83_871 km²',
                        '8_414_638',
                        continent: eu )

    assert_equal 'austria', at.slug    
    assert_equal 'europe/at-austria', at.to_path
  end

  def test_at

    c = Country.parse( 'at',
                       'Austria',
                       'AUT',
                       '83_871 km²',
                       '8_414_638',
                       'un|fifa|uefa|eu|euro|schengen|central_europe|western_europe' )

    c2 = Country.find_by!( key: 'at' )
    assert_equal c.id, c2.id

    assert_equal 'Austria',   c.name
    assert_equal 8_414_638,   c.pop
    assert_equal 83_871,      c.area
    ## todo: assert tag count; add supra:eu etc.

    ### test place
    assert_equal  'Austria', c.place.name
  end


end # class TestParseCountry

