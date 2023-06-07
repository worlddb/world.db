# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Finland'
  c.key    = 'fi'
  c.alpha3 = 'FIN'
  c.fifa   = 'FIN'
  c.net    = 'fi'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Finland / Europe
  #    tags: europe, northern europe, nordic, un, eu, fifa, uefa, euro, schengen
  FI = c

  WORLD      << FI
  WORLD_UN   << FI
  WORLD_ISO  << FI
  WORLD_FIFA << FI

  EUROPE       << FI
  EUROPE_EU    << FI
  EUROPE_EURO  << FI



end  # module WorldLite
