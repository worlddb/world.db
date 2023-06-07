# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Philippines'
  c.key    = 'ph'
  c.alpha3 = 'PHL'
  c.fifa   = 'PHI'
  c.net    = 'ph'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Philippines / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  PH = c

  WORLD      << PH
  WORLD_UN   << PH
  WORLD_ISO  << PH
  WORLD_FIFA << PH




end  # module WorldLite
