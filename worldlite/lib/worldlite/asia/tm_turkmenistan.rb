# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Turkmenistan'
  c.key    = 'tm'
  c.alpha3 = 'TKM'
  c.fifa   = 'TKM'
  c.net    = 'tm'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Turkmenistan / Asia
  #    tags: asia, un, fifa, afc, central asia
  TM = c

  WORLD      << TM
  WORLD_UN   << TM
  WORLD_ISO  << TM
  WORLD_FIFA << TM




end  # module WorldLite
