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


  def test_read
    reader = TreeReader.from_file( "#{WorldDb.root}/test/data/de-deutschland/3--by-bayern/4--oberfranken/orte.txt" )
 
    reader.each_line do |stack|
      names = stack.map { |item| "(#{item.level}) #{item.value}" }
      last = stack.last

      puts "    #{names.join( ' › ' )}:"
      puts "      key: >#{last.key}<, level: >#{last.level}<, value: >#{last.value}<"
    end
  end


  def xxx_test_oberfranken
    de = Country.create!( key: 'de',
                          name: 'Germany',
                          code: 'GER',
                          pop: 0,
                          area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/de-deutschland" )
    reader.load_setup( 'setups/adm' )

    assert_equal 16, de.states.count

    by = State.find_by!( key: 'by' )
    assert_equal 'Bayern [Bavaria]', by.name
    assert_equal 7, by.parts.count

    ofr = Part.find_by!( key: 'ofr' )
    assert_equal 'Oberfranken', ofr.name
    assert_equal 13, ofr.counties.count
    
    baland = County.find_by!( key: 'baland' )
    assert_equal 'Bamberg (Land)', baland.name
  end

end # class TestTreeReader

