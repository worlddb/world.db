# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/adm/test_fixture_matcher_adm3.rb


require 'helper'


class TestFixtureMatcherAdm3 < MiniTest::Test

  include WorldDb::Matcher

  def test_oberfranken
    oberfranken = [
       'de-deutschland!/by-bayern/4--oberfranken/counties',
       'de-deutschland/by-bayern/4--oberfranken/counties',
       'de-deutschland!/3--by-bayern/4--oberfranken/counties',
       'de-deutschland/3--by-bayern/4--oberfranken/counties',
       'europe/de-deutschland!/3--by-bayern/4--oberfranken/counties',
       'europe/de-deutschland/3--by-bayern/4--oberfranken/counties',
    ]
    assert_match_adm3_for_country( oberfranken, 'de', 'by', 'oberfranken' )
  end # method test_oberfranken


private
  def assert_match_adm3_for_country( ary, expected_country_key, expected_state_key, expected_adm2 )
    ary.each do |name|
      found = match_adm3_for_country( name ) do |country_key,state_key,adm2|
        assert_equal country_key, expected_country_key,  "#{expected_country_key} expected is #{country_key}"
        assert_equal state_key,   expected_state_key,    "#{expected_state_key} expected is #{state_key}"
        assert_equal adm2,        expected_adm2,         "#{expected_adm2} expected is #{adm2}"
      end
      assert found, "no match for '#{name}'"
    end
  end

end # class TestFixtureMatcherAdm3

