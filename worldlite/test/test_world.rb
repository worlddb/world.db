# encoding: utf-8

require 'helper'


class TestWorld < MiniTest::Unit::TestCase   ## Minitest::Test

  include WorldLite    #  e.g. use WORLD, AT, etc.

  def test_world
    assert_equal  245, WORLD.size
    
    puts ""
    puts "WORLD      #{WORLD.size}"
    puts "WORLD_UN   #{WORLD_UN.size}"
    puts "WORLD_ISO  #{WORLD_ISO.size}"
    puts "WORLD_FIFA #{WORLD_FIFA.size}"
    puts "WORLD_G8   #{WORLD_G8.size}"

    pp WORLD_G8

    puts "WORLD_G20  #{WORLD_G20.size}"

    pp WORLD_G20

    puts "WORLD_COMMONWEALTH #{WORLD_COMMONWEALTH.size}"

    puts ""
    puts "EUROPE      #{EUROPE.size}"
    puts "EUROPE_EU   #{EUROPE_EU.size}"
    puts "EUROPE_EURO #{EUROPE_EURO.size}"
    
    pp WORLD
  end

  def test_at
    assert_equal 'Austria', AT.name
    assert_equal 'at',      AT.key
  end

  def test_be
    assert_equal 'Belgium', BE.name
    assert_equal 'be',      BE.key
  end

end # class TestWorld
