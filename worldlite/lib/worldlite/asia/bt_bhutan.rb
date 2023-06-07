# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bhutan'
  c.key    = 'bt'
  c.alpha3 = 'BTN'
  c.fifa   = 'BHU'
  c.net    = 'bt'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Bhutan / Asia
  #    tags: asia, un, fifa, afc, south asia
  BT = c

  WORLD      << BT
  WORLD_UN   << BT
  WORLD_ISO  << BT
  WORLD_FIFA << BT




end  # module WorldLite
