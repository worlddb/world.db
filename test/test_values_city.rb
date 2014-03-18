# encoding: utf-8


require 'helper'

class TestValuesCity < MiniTest::Unit::TestCase

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_city_values

    at = Country.create!( key: 'at',
                          title: 'Austria',
                          code: 'AUT',
                          pop: 8_414_638,
                          area: 83_871 )

    w = Region.create!( key: 'w',
                        title: 'Wien',
                        country_id: at.id )

    new_attributes = {
      key:        'wien',
      title:      'Wien',
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
    assert_equal c.id, c2.id

    assert_equal c.title, new_attributes[:title]
    assert_equal c.pop,   1_731_236
    assert_equal c.popm,  1_724_000
    assert_equal c.m,     true
    assert_equal c.region_id,  w.id
    assert_equal c.country_id, at.id
  end


end # class TestValuesCity

