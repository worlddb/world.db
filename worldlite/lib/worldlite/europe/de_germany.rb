# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Germany'
  c.key    = 'de'
  c.alpha3 = 'DEU'
  c.fifa   = 'GER'
  c.net    = 'de'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Germany / Europe
  #    tags: europe, western europe, central europe, un, g8, g20, eu, fifa, uefa, euro, schengen
  DE = c

  WORLD      << DE
  WORLD_UN   << DE
  WORLD_ISO  << DE
  WORLD_FIFA << DE
  WORLD_G8   << DE
  WORLD_G20  << DE

  EUROPE       << DE
  EUROPE_EU    << DE
  EUROPE_EURO  << DE



end  # module WorldLite
