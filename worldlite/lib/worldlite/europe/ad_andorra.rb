# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Andorra'
  c.key    = 'ad'
  c.alpha3 = 'AND'
  c.fifa   = 'AND'
  c.net    = 'ad'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Andorra / Europe
  #    tags: europe, western europe, un, fifa, uefa, microstate
  AD = c

  WORLD      << AD
  WORLD_UN   << AD
  WORLD_ISO  << AD
  WORLD_FIFA << AD

  EUROPE       << AD



end  # module WorldLite
