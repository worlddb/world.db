# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Malta'
  c.key    = 'mt'
  c.alpha3 = 'MLT'
  c.fifa   = 'MLT'
  c.net    = 'mt'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Malta / Europe
  #    tags: europe, southern europe, un, eu, commonwealth, fifa, uefa, euro, schengen, microstate, mediterranean
  MT = c

  WORLD      << MT
  WORLD_UN   << MT
  WORLD_ISO  << MT
  WORLD_FIFA << MT
  WORLD_COMMONWEALTH  << MT

  EUROPE       << MT
  EUROPE_EU    << MT
  EUROPE_EURO  << MT



end  # module WorldLite
