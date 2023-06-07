# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Portugal'
  c.key    = 'pt'
  c.alpha3 = 'PRT'
  c.fifa   = 'POR'
  c.net    = 'pt'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Portugal / Europe
  #    tags: europe, southern europe, un, eu, fifa, uefa, euro, schengen
  PT = c

  WORLD      << PT
  WORLD_UN   << PT
  WORLD_ISO  << PT
  WORLD_FIFA << PT

  EUROPE       << PT
  EUROPE_EU    << PT
  EUROPE_EURO  << PT



end  # module WorldLite
