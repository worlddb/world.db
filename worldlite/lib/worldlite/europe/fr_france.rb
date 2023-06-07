# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'France'
  c.key    = 'fr'
  c.alpha3 = 'FRA'
  c.fifa   = 'FRA'
  c.net    = 'fr'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  France / Europe
  #    tags: europe, western europe, un, g8, g20, eu, fifa, uefa, euro, schengen
  FR = c

  WORLD      << FR
  WORLD_UN   << FR
  WORLD_ISO  << FR
  WORLD_FIFA << FR
  WORLD_G8   << FR
  WORLD_G20  << FR

  EUROPE       << FR
  EUROPE_EU    << FR
  EUROPE_EURO  << FR



end  # module WorldLite
