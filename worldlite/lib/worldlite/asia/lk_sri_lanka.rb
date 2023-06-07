# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Sri Lanka'
  c.key    = 'lk'
  c.alpha3 = 'LKA'
  c.fifa   = 'SRI'
  c.net    = 'lk'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Sri Lanka / Asia
  #    tags: asia, un, commonwealth, fifa, afc, south asia
  LK = c

  WORLD      << LK
  WORLD_UN   << LK
  WORLD_ISO  << LK
  WORLD_FIFA << LK
  WORLD_COMMONWEALTH  << LK




end  # module WorldLite
