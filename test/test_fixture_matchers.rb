# encoding: utf-8

require 'helper'


class TestFixtureMatchers < MiniTest::Unit::TestCase

  include WorldDb::Matcher


  def  test_cities_for_country

    cities_at = [
      'europe/at/cities',
      'europe/at-austria/cities',
      'at-austria/cities',
      'at-austria!/cities'
    ]

    cities_at.each do |name|
      found = match_cities_for_country( name ) do |country_key|
        assert_equal country_key, 'at'
      end
      assert found
    end
  end # method test_cities_for_country

  def test_country

    beers_at = [
      'europe/at/beers',
      'europe/at-austria/beers',
      'at-austria/beers',
      'at-austria!/beers',
      '1--at-austria--central/beers',
      'europe/1--at-austria--central/beers'
    ]

    beers_at.each do |name|
      found = match_xxx_for_country( name, 'beers' ) do |country_key|
        assert_equal country_key, 'at'
      end
      assert found
    end

    breweries_at = [
      'europe/at/breweries',
      'europe/at-austria/breweries',
      'at-austria/breweries',
      'at-austria!/breweries'
    ]

    breweries_at.each do |name|
      found = match_xxx_for_country( name, 'breweries' ) do |country_key|
        assert_equal country_key, 'at'
      end
      assert found
    end
  end # method test_country


  def test_country_n_region

    beers_at = [
      'europe/at-austria/w-wien/beers',
      'at-austria/w-wien/beers',
      'at-austria!/w-wien/beers',
      '1--at-austria--central/1--w-wien--eastern/beers',
      'europe/1--at-austria--central/1--w-wien--eastern/beers',
      'at-austria/1--w-wien--eastern/beers',
      'europe/at-austria!/1--w-wien--eastern/beers',
      '1--at-austria--central/w-wien/beers',
      'europe/1--at-austria--central/w-wien/beers'
    ]

    beers_at.each do |name|
      found = match_xxx_for_country_n_region( name, 'beers' ) do |country_key,region_key|
        assert_equal country_key, 'at'
        assert_equal region_key,  'w'
      end
      assert found
    end

    breweries_at = [
      'europe/at-austria/w-wien/breweries',
      'at-austria/w-wien/breweries',
      'at-austria!/w-wien/breweries'
    ]

    breweries_at.each do |name|
      found = match_xxx_for_country_n_region( name, 'breweries' ) do |country_key,region_key|
        assert_equal country_key, 'at'
        assert_equal region_key,  'w'
      end
      assert found
    end
  end # method test_country_n_region


end # class TestFixtureMatchers