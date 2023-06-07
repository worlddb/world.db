# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Maldives'
  c.key    = 'mv'
  c.alpha3 = 'MDV'
  c.fifa   = 'MDV'
  c.net    = 'mv'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Maldives / Asia
  #    tags: asia, un, commonwealth, fifa, afc, microstate, south asia
  MV = c

  WORLD      << MV
  WORLD_UN   << MV
  WORLD_ISO  << MV
  WORLD_FIFA << MV
  WORLD_COMMONWEALTH  << MV




end  # module WorldLite
