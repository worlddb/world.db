# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Austria'
  c.key    = 'at'
  c.alpha3 = 'AUT'
  c.fifa   = 'AUT'
  c.net    = 'at'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Austria / Europe
  #    tags: europe, western europe, central europe, un, eu, fifa, uefa, euro, schengen
  AT = c

  WORLD      << AT
  WORLD_UN   << AT
  WORLD_ISO  << AT
  WORLD_FIFA << AT

  EUROPE       << AT
  EUROPE_EU    << AT
  EUROPE_EURO  << AT



end  # module WorldLite
