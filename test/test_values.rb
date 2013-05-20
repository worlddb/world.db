# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_helper.rb
#  or better
#     rake test

require 'helper'

class TestValues < MiniTest::Unit::TestCase

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_country_values
    
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
    assert( c.id == c2.id )

    assert( c.title   == new_attributes[:title] )
    assert( c.pop     == 8_414_638 )
    assert( c.area    == 83_871 )
    ## todo: assert tag count; add supra:eu etc.
  end

  def test_load_region_values

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
    assert( r.id == r2.id )

    assert( r.title == new_attributes[:title] )
    assert( r.area  == 415 )
    ## todo: assert country_id & country.title for assoc
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
    assert( c.id == c2.id )

    assert( c.title      == new_attributes[:title] )
    assert( c.pop        == 1_731_236 )
    assert( c.popm       == 1_724_000 )
    assert( c.m          == true )
    assert( c.region_id  == w.id  )
    assert( c.country_id == at.id )
  end


end # class TestValues

