# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Uzbekistan'
  c.key    = 'uz'
  c.alpha3 = 'UZB'
  c.fifa   = 'UZB'
  c.net    = 'uz'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Uzbekistan / Asia
  #    tags: asia, un, fifa, afc, central asia
  UZ = c

  WORLD      << UZ
  WORLD_UN   << UZ
  WORLD_ISO  << UZ
  WORLD_FIFA << UZ




end  # module WorldLite
