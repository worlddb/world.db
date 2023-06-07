# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'India'
  c.key    = 'in'
  c.alpha3 = 'IND'
  c.fifa   = 'IND'
  c.net    = 'in'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  India / Asia
  #    tags: asia, un, g5, g20, commonwealth, fifa, afc, south asia
  IN = c

  WORLD      << IN
  WORLD_UN   << IN
  WORLD_ISO  << IN
  WORLD_FIFA << IN
  WORLD_G20  << IN
  WORLD_COMMONWEALTH  << IN




end  # module WorldLite
