# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Spain'
  c.key    = 'es'
  c.alpha3 = 'ESP'
  c.fifa   = 'ESP'
  c.net    = 'es'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Spain / Europe
  #    tags: europe, southern europe, un, eu, fifa, uefa, euro, schengen
  ES = c

  WORLD      << ES
  WORLD_UN   << ES
  WORLD_ISO  << ES
  WORLD_FIFA << ES

  EUROPE       << ES
  EUROPE_EU    << ES
  EUROPE_EURO  << ES



end  # module WorldLite
