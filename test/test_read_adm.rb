# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_read_adm.rb


require 'helper'

class TestReadAdm < MiniTest::Test

  def setup
    #  delete all countries, regions, cities in in-memory only db
    WorldDb.delete!
  end

  def test_de
    de = Country.create!( key: 'de',
                          name: 'Germany',
                          code: 'GER',
                          pop: 0,
                          area: 0 )

    reader = WorldDb::Reader.new( "#{WorldDb.root}/test/data/de-deutschland" )
    reader.load_setup( 'setups/adm' )


    ###
    ## todo/fix: shorten level to l -- why, why not???

    assert_equal 16, de.regions.where(level:1).count
    ## assert_equal 16+??, de.regions.count

    by = Region.find_by_key!( 'by' )
    assert_equal 7, by.regions.where(level:2).count
    ## assert_equal 7+??, by.regions.count

    ## pp by.regions

    ob = Region.find_by_key!( 'ob' )
    assert_equal 'Oberbayern', ob.name
    assert_equal 23, ob.regions.where(level:3).count
    assert_equal 23, ob.regions.count

    ofr = Region.find_by_key!( 'ofr' )
    assert_equal 'Oberfranken', ofr.name
    assert_equal 13, ofr.regions.where(level:3).count
    assert_equal 13, ofr.regions.count
  end

end # class TestReadAdm
