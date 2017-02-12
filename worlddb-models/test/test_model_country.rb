# encoding: utf-8

require 'helper'

class TestModelCountry < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end

  def test_to_path
    eu = Continent.create!( key: 'eu', name: 'Europe' )
    assert_equal 'europe', eu.slug
    
    at = Country.create!( key: 'at', name: 'Austria', code: 'AUT', area: 83_871, pop: 8_414_638, continent: eu )
    assert_equal 'austria', at.slug
    
    assert_equal 'europe/at-austria', at.to_path
  end

  def test_load_values

    new_attributes = {
      key:      'at',
      name:     'Austria',
      alt_names: ''
    }

    values = [
      'AUT',
      '83_871',
      '8_414_638',
      'un|fifa|uefa|eu|euro|schengen|central_europe|western_europe'
    ]

    c = Country.create_or_update_from_attribs( new_attributes, values )

    c2 = Country.find_by_key!( new_attributes[:key] )
    assert_equal c.id, c2.id

    assert_equal new_attributes[:name], c.name
    assert_equal 8_414_638,             c.pop
    assert_equal 83_871,                c.area
    ## todo: assert tag count; add supra:eu etc.

    ### test place
    assert_equal  new_attributes[:name], c.place.name
  end


end # class TestModelCountry

