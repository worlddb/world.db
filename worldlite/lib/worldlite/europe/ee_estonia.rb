# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Estonia'
  c.key    = 'ee'
  c.alpha3 = 'EST'
  c.fifa   = 'EST'
  c.net    = 'ee'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Estonia / Europe
  #    tags: europe, northern europe, eastern europe, baltic, un, eu, fifa, uefa, euro, schengen
  EE = c

  WORLD      << EE
  WORLD_UN   << EE
  WORLD_ISO  << EE
  WORLD_FIFA << EE

  EUROPE       << EE
  EUROPE_EU    << EE
  EUROPE_EURO  << EE



end  # module WorldLite
