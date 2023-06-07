# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Kazakhstan'
  c.key    = 'kz'
  c.alpha3 = 'KAZ'
  c.fifa   = 'KAZ'
  c.net    = 'kz'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Kazakhstan / Asia
  #    tags: asia, europe, un, fifa, uefa, central asia
  KZ = c

  WORLD      << KZ
  WORLD_UN   << KZ
  WORLD_ISO  << KZ
  WORLD_FIFA << KZ




end  # module WorldLite
