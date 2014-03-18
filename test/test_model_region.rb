# encoding: utf-8


require 'helper'

class TestModelRegion < MiniTest::Unit::TestCase

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_values

    at = Country.create!( key: 'at',
                          title: 'Austria',
                          code: 'AUT',
                          pop: 8_414_638,
                          area: 83_871 )

    new_attributes = {
      key:        'w',
      title:      'Wien',
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

    assert_equal r.title, new_attributes[:title]
    assert_equal r.area, 415
    ## todo: assert country_id & country.title for assoc
  end

end # class TestModelRegion

