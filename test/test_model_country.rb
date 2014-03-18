# encoding: utf-8

require 'helper'

class TestModelCountry < MiniTest::Unit::TestCase

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_values

    new_attributes = {
      key:      'at',
      title:    'Austria',
      synonyms: ''
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

    assert_equal c.title, new_attributes[:title]
    assert_equal c.pop,   8_414_638
    assert_equal c.area,  83_871
    ## todo: assert tag count; add supra:eu etc.
  end


end # class TestModelCountry

