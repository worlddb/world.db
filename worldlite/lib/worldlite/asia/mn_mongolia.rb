# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Mongolia'
  c.key    = 'mn'
  c.alpha3 = 'MNG'
  c.fifa   = 'MGL'
  c.net    = 'mn'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Mongolia / Asia
  #    tags: asia, un, fifa, afc, east asia
  MN = c

  WORLD      << MN
  WORLD_UN   << MN
  WORLD_ISO  << MN
  WORLD_FIFA << MN




end  # module WorldLite
