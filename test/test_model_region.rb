# encoding: utf-8


require 'helper'

class TestModelRegion < MiniTest::Unit::TestCase

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_values

    at = Country.create!( key: 'at',
                          name: 'Austria',
                          code: 'AUT',
                          pop: 8_414_638,
                          area: 83_871 )

    new_attributes = {
      key:        'w',
      name:       'Wien',
      synonyms:   '',
      country_id: at.id
    }

    values = [
      '415 km²',
      'eastern austria'
    ]

    r = Region.create_or_update_from_attribs( new_attributes, values )

    r2 = Region.find_by_key!( new_attributes[:key] )
    assert_equal r.id, r2.id

    assert_equal new_attributes[:name],  r.name 
    assert_equal 415,                    r.area 
    assert_equal at.id,                  r.country_id

    ### test place
    assert_equal  new_attributes[:name], r.place.name

    ## test assocs
    assert_equal  'Austria', r.country.name
  end

end # class TestModelRegion

