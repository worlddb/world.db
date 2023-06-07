# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Slovenia'
  c.key    = 'si'
  c.alpha3 = 'SVN'
  c.fifa   = 'SVN'
  c.net    = 'si'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Slovenia / Europe
  #    tags: europe, southern europe, central europe, un, eu, fifa, uefa, euro, schengen
  SI = c

  WORLD      << SI
  WORLD_UN   << SI
  WORLD_ISO  << SI
  WORLD_FIFA << SI

  EUROPE       << SI
  EUROPE_EU    << SI
  EUROPE_EURO  << SI



end  # module WorldLite
