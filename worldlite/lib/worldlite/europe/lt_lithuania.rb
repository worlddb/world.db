# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Lithuania'
  c.key    = 'lt'
  c.alpha3 = 'LTU'
  c.fifa   = 'LTU'
  c.net    = 'lt'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Lithuania / Europe
  #    tags: europe, northern europe, baltic, un, eu, fifa, uefa, schengen
  LT = c

  WORLD      << LT
  WORLD_UN   << LT
  WORLD_ISO  << LT
  WORLD_FIFA << LT

  EUROPE       << LT
  EUROPE_EU    << LT



end  # module WorldLite
