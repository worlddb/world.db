# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/adm/test_read_adm.rb


require 'helper'

class TestReadAdm < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end

  def test_at
    at = Country.create!( key: 'at',
                          name: 'Austria',
                          code: 'AUT',
                          pop: 0,
                          area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/at-austria" )
    reader.load_setup( 'setups/adm' )

    assert_equal 9, at.states.count
  end


  def test_de
    de = Country.create!( key: 'de',
                          name: 'Germany',
                          code: 'GER',
                          pop: 0,
                          area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/de-deutschland" )
    reader.load_setup( 'setups/adm' )


    assert_equal 16, de.states.count

    by = State.find_by_key!( 'by' )
    assert_equal 7, by.parts.count
    ## assert_equal 23+, by.counties.count

    ## pp by.parts

    ob = Part.find_by_key!( 'ob' )
    assert_equal 'Oberbayern', ob.name
    assert_equal 23, ob.counties.count

    ofr = Part.find_by_key!( 'ofr' )
    assert_equal 'Oberfranken', ofr.name
    assert_equal 13, ofr.counties.count
  end

end # class TestReadAdm

