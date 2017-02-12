# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_state_tree_reader_de.rb


require 'helper'

class TestStateTreeReaderDe < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!

    Country.create!( key: 'de',
                     name: 'Germany',
                     code: 'GER',
                     pop: 0,
                     area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/de-deutschland" )
    reader.load_setup( 'setups/adm' )
  end

  def test_oberfranken_ii   ## small (short) version
    de = Country.find_by!( key: 'de' )
    more_attribs = { country_id: de.id }
    reader = WorldDb::StateTreeReader.from_file( "#{WorldDb.root}/test/data/de-deutschland/3--by-bayern/4--oberfranken/orte_ii.txt",
                                                 more_attribs )
    reader.read

    ofr = Part.find_by!( key: 'ofr' )
    assert_equal 'Oberfranken', ofr.name
    assert_equal 13,            ofr.counties.count

    ba = County.find_by!( key: 'ba' )
    assert_equal 'Bamberg (Stadt)', ba.name
    assert_equal 1,                 ba.munis.count
    
    baland = County.find_by!( key: 'baland' )
    assert_equal 'Bamberg (Land)', baland.name
    assert_equal 2,                baland.munis.count

    hallstadt = Muni.find_by!( key: 'hallstadt' )
    assert_equal 'Hallstadt',      hallstadt.name
    assert_equal 2,                hallstadt.cities.count
    assert_equal 'Bamberg (Land)', hallstadt.county.name

    doerfleins = City.find_by!( key: 'doerfleins' )
    assert_equal 'Dörfleins',      doerfleins.name
    assert_equal 'Hallstadt',      doerfleins.muni.name
    assert_equal 'Bamberg (Land)', doerfleins.muni.county.name
    assert_equal 'Oberfranken',    doerfleins.muni.county.part.name
  end


  def test_oberfranken
    de = Country.find_by!( key: 'de' )
    more_attribs = { country_id: de.id }
    reader = WorldDb::StateTreeReader.from_file( "#{WorldDb.root}/test/data/de-deutschland/3--by-bayern/4--oberfranken/orte.txt",
                                                 more_attribs )
    reader.read

    ba = County.find_by!( key: 'ba' )
    assert_equal 'Bamberg (Stadt)', ba.name
    assert_equal 1,                 ba.munis.count
  end

end # class TestStateTreeReaderDe

