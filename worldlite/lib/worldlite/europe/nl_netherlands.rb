# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Netherlands'
  c.key    = 'nl'
  c.alpha3 = 'NLD'
  c.fifa   = 'NED'
  c.net    = 'nl'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Netherlands / Europe
  #    tags: europe, western europe, un, eu, fifa, uefa, benelux, euro, schengen
  NL = c

  WORLD      << NL
  WORLD_UN   << NL
  WORLD_ISO  << NL
  WORLD_FIFA << NL

  EUROPE       << NL
  EUROPE_EU    << NL
  EUROPE_EURO  << NL



end  # module WorldLite
