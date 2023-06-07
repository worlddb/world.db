# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Singapore'
  c.key    = 'sg'
  c.alpha3 = 'SGB'
  c.fifa   = 'SIN'
  c.net    = 'sg'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Singapore / Asia
  #    tags: asia, un, commonwealth, fifa, afc, microstate, southeast asia
  SG = c

  WORLD      << SG
  WORLD_UN   << SG
  WORLD_ISO  << SG
  WORLD_FIFA << SG
  WORLD_COMMONWEALTH  << SG




end  # module WorldLite
