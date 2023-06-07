# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'San Marino'
  c.key    = 'sm'
  c.alpha3 = 'SMR'
  c.fifa   = 'SMR'
  c.net    = 'sm'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  San Marino / Europe
  #    tags: europe, southern europe, un, fifa, uefa, microstate
  SM = c

  WORLD      << SM
  WORLD_UN   << SM
  WORLD_ISO  << SM
  WORLD_FIFA << SM

  EUROPE       << SM



end  # module WorldLite
