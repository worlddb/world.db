# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Poland'
  c.key    = 'pl'
  c.alpha3 = 'POL'
  c.fifa   = 'POL'
  c.net    = 'pl'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Poland / Europe
  #    tags: europe, central europe, un, eu, fifa, uefa, schengen
  PL = c

  WORLD      << PL
  WORLD_UN   << PL
  WORLD_ISO  << PL
  WORLD_FIFA << PL

  EUROPE       << PL
  EUROPE_EU    << PL



end  # module WorldLite
