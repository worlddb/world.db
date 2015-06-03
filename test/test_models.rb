# encoding: utf-8


require 'helper'

class TestModels < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end

  def test_counts
    assert_equal 0, Name.count
    assert_equal 0, Place.count
    assert_equal 0, Continent.count
    assert_equal 0, Country.count
    assert_equal 0, State.count
    assert_equal 0, City.count

    assert_equal 0, Lang.count
    assert_equal 0, Usage.count
    
    WorldDb.tables
  end

  def test_place_assoc_counts
    # assert_equal 0, Continent.new.place.count
    # assert_equal 0, Country.new.place.count
    # assert_equal 0, State.new.place.count
    # assert_equal 0, City.new.place.count
  end

end # class TestModels

