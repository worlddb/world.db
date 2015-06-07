# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_tree_reader.rb


require 'helper'

class TestTreeReader < MiniTest::Test

  def setup
    #  delete all countries, states, cities in in-memory only db
    WorldDb.delete!
  end


  def test_oberfranken
    reader = TreeReader.from_file( "#{WorldDb.root}/test/data/de-deutschland/3--by-bayern/4--oberfranken/orte.txt" )
 
    reader.each_line do |_|
      ## do nothing for now
    end
    
    assert true ## assume everything ok if we get here
  end

  def test_de
    reader = TreeReader.from_file( "#{WorldDb.root}/test/data/de-deutschland/orte.txt" )
 
    reader.each_line do |_|
      ## do nothing for now
    end

    assert true ## assume everything ok if we get here
  end

end # class TestTreeReader

