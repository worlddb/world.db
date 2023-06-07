# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Belgium'
  c.key    = 'be'
  c.alpha3 = 'BEL'
  c.fifa   = 'BEL'
  c.net    = 'be'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Belgium / Europe
  #    tags: europe, un, eu, fifa, uefa, benelux, euro, schengen
  BE = c

  WORLD      << BE
  WORLD_UN   << BE
  WORLD_ISO  << BE
  WORLD_FIFA << BE

  EUROPE       << BE
  EUROPE_EU    << BE
  EUROPE_EURO  << BE



end  # module WorldLite
