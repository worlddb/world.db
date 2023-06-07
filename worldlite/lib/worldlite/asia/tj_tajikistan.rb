# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tajikistan'
  c.key    = 'tj'
  c.alpha3 = 'TJK'
  c.fifa   = 'TJK'
  c.net    = 'tj'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Tajikistan / Asia
  #    tags: asia, un, fifa, afc, central asia
  TJ = c

  WORLD      << TJ
  WORLD_UN   << TJ
  WORLD_ISO  << TJ
  WORLD_FIFA << TJ




end  # module WorldLite
