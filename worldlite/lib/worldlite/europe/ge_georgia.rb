# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Georgia'
  c.key    = 'ge'
  c.alpha3 = 'GEO'
  c.fifa   = 'GEO'
  c.net    = 'ge'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Georgia / Europe
  #    tags: europe, un, fifa, uefa, western asia, south caucasus
  GE = c

  WORLD      << GE
  WORLD_UN   << GE
  WORLD_ISO  << GE
  WORLD_FIFA << GE

  EUROPE       << GE



end  # module WorldLite
