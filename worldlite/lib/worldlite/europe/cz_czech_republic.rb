# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Czech Republic'
  c.key    = 'cz'
  c.alpha3 = 'CZE'
  c.fifa   = 'CZE'
  c.net    = 'cz'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Czech Republic / Europe
  #    tags: europe, central europe, un, eu, fifa, uefa, schengen
  CZ = c

  WORLD      << CZ
  WORLD_UN   << CZ
  WORLD_ISO  << CZ
  WORLD_FIFA << CZ

  EUROPE       << CZ
  EUROPE_EU    << CZ



end  # module WorldLite
