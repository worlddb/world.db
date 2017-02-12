# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/adm/test_fixture_matcher_tree.rb


require 'helper'


class TestFixtureMatcherTree < MiniTest::Test

  include WorldDb::Matcher

  def test_de
    de = [
       'de-deutschland!/orte',
       'de-deutschland!/3--by-bayern/orte',
       'de-deutschland/3--by-bayern/orte',
       'de-deutschland!/3--by-bayern/4--oberfranken/orte',
       'europe/de-deutschland!/3--by-bayern/orte',
       'europe/de-deutschland/3--by-bayern/orte',
       'europe/de-deutschland!/orte',
    ]
    assert_match_tree_for_country( de, 'de' )
  end # method test_de


  def test_at
    at = [
       'at-austria!/n-niederoesterreich/orte',
       'at-austria/n-niederoesterreich/orte',
       'at-austria!/1--n-niederoesterreich/orte',
       'at-austria!/orte',
       'at-austria/orte',
       'europe/at-austria/1--n-niederoesterreich/orte',
    ]
    assert_match_tree_for_country( at, 'at' )
  end # method test_at


private
  def assert_match_tree_for_country( ary, expected_country_key )
    ary.each do |name|
      found = match_tree_for_country( name ) do |country_key|
        assert_equal country_key, expected_country_key,  "#{expected_country_key} expected is #{country_key}"
      end
      assert found, "no match for '#{name}'"
    end
  end

end # class TestFixtureMatcherTree
