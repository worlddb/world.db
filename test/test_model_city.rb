# encoding: utf-8


require 'helper'

class TestModelCity < MiniTest::Unit::TestCase

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_values

    at = Country.create!( key: 'at',
                          name: 'Austria',
                          code: 'AUT',
                          pop:  8_414_638,
                          area: 83_871 )

    w = Region.create!( key: 'w',
                        name: 'Wien',
                        country_id: at.id )

    new_attributes = {
      key:        'wien',
      name:       'Wien',
      synonyms:   '',
      country_id: at.id
    }

    values = [
      'W', 
      '1_731_236',
      'm:1_724_000'
    ]

    c = City.create_or_update_from_attribs( new_attributes, values )

    c2 = City.find_by_key!( new_attributes[:key] )
    assert_equal c2.id, c.id

    assert_equal new_attributes[:name], c.name
    assert_equal 1_731_236, c.pop
    assert_equal 1_724_000, c.popm
    assert_equal true,      c.m 
    assert_equal w.id,      c.region_id
    assert_equal at.id,     c.country_id
    
    ### test place
    assert_equal  new_attributes[:name], c.place.name

    ## test assocs
    assert_equal  'Wien',    c.region.name
    assert_equal  'Austria', c.region.country.name
    assert_equal  'Austria', c.country.name
  end


end # class TestModelCity
