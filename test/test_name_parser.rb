# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_name_parser.rb


require 'helper'

class TestNameParser < MiniTest::Test

  def test_bayern
    names = NameParser.new.parse( [ 'Bayern [Bavaria]' ] )

    assert_equal 2, names.size
    assert_equal 'Bayern',  names[0]
    assert_equal 'Bavaria', names[1]
  end

  def test_brussel
    names = NameParser.new.parse( [ 'Brussel•Bruxelles [Brussels]' ] )

    ## fix: (auto-)split into three variants e.g.Brussel•Bruxelles, Brussel, Bruxelles
    assert_equal 2, names.size
    assert_equal 'Brussel•Bruxelles',  names[0]
    assert_equal 'Brussels',           names[1]
  end

  def test_antwerp
    names = NameParser.new.parse( [ 'Antwerpen|Anvers [Antwerp]' ] )

    assert_equal 3, names.size
    assert_equal 'Antwerpen', names[0]
    assert_equal 'Anvers',    names[1]
    assert_equal 'Antwerp',   names[2]
  end

end # class TestNameParser
