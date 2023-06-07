# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Luxembourg'
  c.key    = 'lu'
  c.alpha3 = 'LUX'
  c.fifa   = 'LUX'
  c.net    = 'lu'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Luxembourg / Europe
  #    tags: europe, western europe, un, eu, fifa, uefa, benelux, euro, schengen
  LU = c

  WORLD      << LU
  WORLD_UN   << LU
  WORLD_ISO  << LU
  WORLD_FIFA << LU

  EUROPE       << LU
  EUROPE_EU    << LU
  EUROPE_EURO  << LU



end  # module WorldLite
