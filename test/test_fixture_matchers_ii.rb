# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_fixture_matchers_ii.rb


require 'helper'


class TestFixtureMatchersII < MiniTest::Test

  include WorldDb::Matcher

  def test_country_n_state_breweries_franken
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
    ]
    assert_match_xxx_for_country_n_state( breweries_franken, 'breweries', 'de', 'by' )
  end # method test_country_n_state_breweries

  def test_country_n_state_breweries_bayern
    breweries_bayern = [
      'de-deutschland/3--by-bayern!/1--oberbayern/breweries_(l)',
      'de-deutschland/3--by-bayern!/1--oberbayern/breweries_(m)',
      'de-deutschland/3--by-bayern!/1--oberbayern/breweries',
      'de-deutschland/3--by-bayern!/2--niederbayern/breweries',
      'de-deutschland/3--by-bayern!/2--niederbayern/breweries_100_000+',
      'de-deutschland/3--by-bayern!/2--niederbayern/breweries_20_000+',
      'de-deutschland/3--by-bayern!/3--oberpfalz/breweries',
      'de-deutschland/3--by-bayern!/3--oberpfalz/breweries_100_000+',
      'de-deutschland/3--by-bayern!/3--oberpfalz/breweries_20_000+',
      'de-deutschland/3--by-bayern!/4--schwaben/breweries',
      'de-deutschland/3--by-bayern!/4--schwaben/breweries_100_000+',
      'de-deutschland/3--by-bayern!/4--schwaben/breweries_20_000+',
    ]
    assert_match_xxx_for_country_n_state( breweries_bayern, 'breweries', 'de', 'by' )
  end # method test_country_n_state_breweries


  def test_country_n_state_brewpubs_franken
    brewpubs_franken = [
       'de-deutschland/by-bayern/franken!/3--unterfranken/brewpubs',
    ]
    assert_match_xxx_for_country_n_state( brewpubs_franken, 'brewpubs', 'de', 'by' )
  end

  def test_country_n_state_brewpubs_bayern
    brewpubs_bayern = [
      'de-deutschland/3--by-bayern!/1--oberbayern/brewpubs',
      'de-deutschland/3--by-bayern!/2--niederbayern/brewpubs',
      'de-deutschland/3--by-bayern!/3--oberpfalz/brewpubs',
      'de-deutschland/3--by-bayern!/4--schwaben/brewpubs',
    ]
    assert_match_xxx_for_country_n_state( brewpubs_bayern, 'brewpubs', 'de', 'by' )
  end


  def test_country_n_state_beers_franken
    beers_franken = [
       'de-deutschland/by-bayern/franken!/1--oberfranken/100_000+_beers',
       'de-deutschland/by-bayern/franken!/1--oberfranken/beers',
       'de-deutschland/by-bayern/franken!/1--oberfranken/fichtelgebirge-bayreuth--beers',
       'de-deutschland/by-bayern/franken!/1--oberfranken/steigerwald-bamberg--beers',
       'de-deutschland/by-bayern/franken!/3--unterfranken/beers_100_000+',
    ]
    assert_match_xxx_for_country_n_state( beers_franken, 'beers', 'de', 'by' )
  end # method test_country_n_state_beers

  def test_country_n_state_beers_bayern
    beers_bayern = [
      'de-deutschland/3--by-bayern!/1--oberbayern/beers--muenchen',
      'de-deutschland/3--by-bayern!/1--oberbayern/beers_l',
      'de-deutschland/3--by-bayern!/1--oberbayern/beers_m',
      'de-deutschland/3--by-bayern!/1--oberbayern/beers',
      'de-deutschland/3--by-bayern!/2--niederbayern/beers',
      'de-deutschland/3--by-bayern!/2--niederbayern/beers_100_000+',
      'de-deutschland/3--by-bayern!/3--oberpfalz/beers',
      'de-deutschland/3--by-bayern!/3--oberpfalz/beers_100_000+',
      'de-deutschland/3--by-bayern!/4--schwaben/beers_100_000+',
    ]
    assert_match_xxx_for_country_n_state( beers_bayern, 'beers', 'de', 'by' )
  end # method test_country_n_state_beers


private
  def assert_match_xxx_for_country_n_state( ary, xxx, expected_country_key, expected_state_key )
    ary.each do |name|
      found = match_xxx_for_country_n_state( name, xxx ) do |country_key,state_key|
        assert_equal country_key, expected_country_key,  "#{expected_country_key} expected is #{country_key}"
        assert_equal state_key,  expected_state_key,   "#{expected_state_key} expected is #{state_key}"
      end
      assert found, "no match for '#{name}'"
    end
  end

end # class TestFixtureMatchersII

