# encoding: utf-8


require 'helper'

class TestModelState < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
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
      alt_names:  '',
      country_id: at.id
    }

    values = [
      '415 km²',
      'eastern austria'
    ]

    st = State.create_or_update_from_attribs( new_attributes, values )

    st2 = State.find_by_key!( new_attributes[:key] )
    assert_equal st.id, st2.id

    assert_equal new_attributes[:name],  st.name 
    assert_equal 415,                    st.area 
    assert_equal at.id,                  st.country_id

    ### test place
    assert_equal  new_attributes[:name], st.place.name

    ## test assocs
    assert_equal  'Austria', st.country.name
  end

end # class TestModelState

