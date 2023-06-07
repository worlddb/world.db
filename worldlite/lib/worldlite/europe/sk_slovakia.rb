# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Slovakia'
  c.key    = 'sk'
  c.alpha3 = 'SVK'
  c.fifa   = 'SVK'
  c.net    = 'sk'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Slovakia / Europe
  #    tags: europe, central europe, un, eu, fifa, uefa, euro, schengen
  SK = c

  WORLD      << SK
  WORLD_UN   << SK
  WORLD_ISO  << SK
  WORLD_FIFA << SK

  EUROPE       << SK
  EUROPE_EU    << SK
  EUROPE_EURO  << SK



end  # module WorldLite
