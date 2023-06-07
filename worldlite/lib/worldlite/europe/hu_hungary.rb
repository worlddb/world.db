# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Hungary'
  c.key    = 'hu'
  c.alpha3 = 'HUN'
  c.fifa   = 'HUN'
  c.net    = 'hu'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Hungary / Europe
  #    tags: europe, central europe, un, eu, fifa, uefa, schengen
  HU = c

  WORLD      << HU
  WORLD_UN   << HU
  WORLD_ISO  << HU
  WORLD_FIFA << HU

  EUROPE       << HU
  EUROPE_EU    << HU



end  # module WorldLite
