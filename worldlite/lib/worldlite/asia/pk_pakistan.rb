# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Pakistan'
  c.key    = 'pk'
  c.alpha3 = 'PAK'
  c.fifa   = 'PAK'
  c.net    = 'pk'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Pakistan / Asia
  #    tags: asia, un, commonwealth, fifa, afc, south asia
  PK = c

  WORLD      << PK
  WORLD_UN   << PK
  WORLD_ISO  << PK
  WORLD_FIFA << PK
  WORLD_COMMONWEALTH  << PK




end  # module WorldLite
