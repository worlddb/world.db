# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_model_city.rb

require 'helper'

class TestModelCity < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end

  def test_load_values

    at = Country.create!( key: 'at',
                          name: 'Austria',
                          code: 'AUT',
                          pop:  8_414_638,
                          area: 83_871 )

    w = State.create!( key: 'w',
                        name: 'Wien',
                        country_id: at.id )

    new_attributes = {
      key:        'wien',
      name:       'Wien',
      alt_names:  '',
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
    assert_equal w.id,      c.state_id
    assert_equal at.id,     c.country_id

    ### test place
    assert_equal  new_attributes[:name], c.place.name

    ## test assocs
    assert_equal  'Wien',    c.state.name
    assert_equal  'Austria', c.state.country.name
    assert_equal  'Austria', c.country.name


    #####
    # check (auto-)added metro record

    m = Metro.find_by_key!( new_attributes[:key] )
    assert_equal new_attributes[:name], m.name
    assert_equal 1_724_000,  m.pop
    assert_equal at.id,      m.country_id
    
    ## test assocs
    assert_equal  1,         m.cities.count
    assert_equal  'Wien',    m.cities.first.name
    assert_equal  'Austria', m.country.name

    assert_equal  'Wien',    c.metro.name
    assert_equal  m.id,      c.metro.id
  end

end # class TestModelCity
