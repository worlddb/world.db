# encoding: utf-8


require 'helper'

class TestModelComp < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end


  def test_title
    at = Country.create!( key: 'at',
                          name: 'Austria',
                          code: 'AUT',
                          pop: 8_414_638,
                          area: 83_871 )

    w = State.create!( key: 'w',
                        name: 'Wien',
                        country_id: at.id )

    new_attributes = {
      key:        'wien',
      name:      'Wien'
    }

    c = City.create!(  key:        new_attributes[:key],
                       name:       new_attributes[:name],  # note: assign "old" title attrib
                       state_id:  w.id,
                       country_id: at.id )

    c2 = City.find_by_key!( new_attributes[:key] )
    assert_equal c2.id, c.id

    assert_equal new_attributes[:name], c.name
    ## assert_equal new_attributes[:name], c.title    ## todo: move to comapt 
    assert_equal new_attributes[:key],  c.key
    assert_equal false,     c.m
    assert_equal w.id,      c.state_id
    assert_equal at.id,     c.country_id
  end


end # class TestModelComp

