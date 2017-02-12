# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_state_tree_reader_at.rb


require 'helper'

class TestStateTreeReaderAt < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!

    Country.create!( key: 'at',
                     name: 'Austria',
                     code: 'AUT',
                     pop: 0,
                     area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/at-austria" )
    reader.load_setup( 'setups/adm' )
  end

  def test_orte
    at = Country.find_by!( key: 'at' )
    more_attribs = { country_id: at.id }
    reader = WorldDb::StateTreeReader.from_file( "#{WorldDb.root}/test/data/at-austria/orte.txt",
                                                 more_attribs )
    reader.read

    n = State.find_by!( key: 'n' )
    assert_equal 'Niederösterreich',  n.name
    assert_equal 25,                                  n.counties.count

    ks = County.find_by!( key: 'ks' )
    assert_equal 'Krems an der Donau (Stadt)', ks.name
    assert_equal 1,                            ks.munis.count
    
    k = Muni.find_by!( key: 'kremsanderdonau' )  ## Statutarstadt (Gemeinde)
    assert_equal 'Krems an der Donau',         k.name
    assert_equal 12,                           k.cities.count
    assert_equal 'Krems an der Donau (Stadt)', k.county.name

    gneixendorf = City.find_by!( key: 'gneixendorf' )
    assert_equal 'Gneixendorf',                      gneixendorf.name
    assert_equal 'Krems an der Donau',               gneixendorf.muni.name
    assert_equal 'Krems an der Donau (Stadt)',       gneixendorf.muni.county.name
    assert_equal 'Niederösterreich', gneixendorf.muni.county.state.name
  end

end # class TestStateTreeReaderAt

