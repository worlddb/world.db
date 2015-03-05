# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_fixture_matchers_ii.rb


require 'helper'


class TestFixtureMatchersII < MiniTest::Test

  include WorldDb::Matcher

  def test_country_n_region_breweries

    breweries_franken = [
       'de-deutschland/by-bayern/franken!/1--oberfranken/100_000+_breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/20_000+-breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/coburger-land--breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/fichtelgebirge--breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/fraenkische-schweiz--breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/frankenwald--breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/hassberge--breweries',
       'de-deutschland/by-bayern/franken!/1--oberfranken/steigerwald--breweries',
       'de-deutschland/by-bayern/franken!/2--mittelfranken/breweries',
       'de-deutschland/by-bayern/franken!/2--mittelfranken/breweries_20_000+',
       'de-deutschland/by-bayern/franken!/3--unterfranken/breweries',
       'de-deutschland/by-bayern/franken!/3--unterfranken/breweries_100_000+',
       'de-deutschland/by-bayern/franken!/3--unterfranken/breweries_20_000+',
       'de-deutschland/by-bayern/franken!/3--unterfranken/brewpubs',
    ]

    breweries_franken.each do |name|
      found = match_xxx_for_country_n_region( name, 'breweries' ) do |country_key,region_key|
        assert_equal country_key, 'de', "de expected is #{country_key}"
        assert_equal region_key,  'by', "by expected is #{region_key}"
      end
      assert found, "no match for '#{name}'"
    end
  end # method test_country_n_region_breweries


  def test_country_n_region_beers

    beers_franken = [
       'de-deutschland/by-bayern/franken!/1--oberfranken/100_000+_beers',
       'de-deutschland/by-bayern/franken!/1--oberfranken/beers',
       'de-deutschland/by-bayern/franken!/1--oberfranken/fichtelgebirge-bayreuth--beers',
       'de-deutschland/by-bayern/franken!/1--oberfranken/steigerwald-bamberg--beers',
       'de-deutschland/by-bayern/franken!/3--unterfranken/beers_100_000+',
    ]

    beers_franken.each do |name|
      found = match_xxx_for_country_n_region( name, 'beers' ) do |country_key,region_key|
        assert_equal country_key, 'de', "de expected is #{country_key}"
        assert_equal region_key,  'by', "by expected is #{region_key}"
      end
      assert found, "no match for '#{name}'"
    end

  end # method test_country_n_region_beers


end # class TestFixtureMatchersII
