# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Greece'
  c.key    = 'gr'
  c.alpha3 = 'GRC'
  c.fifa   = 'GRE'
  c.net    = 'gr'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Greece / Europe
  #    tags: europe, southern europe, un, eu, fifa, uefa, euro, schengen
  GR = c

  WORLD      << GR
  WORLD_UN   << GR
  WORLD_ISO  << GR
  WORLD_FIFA << GR

  EUROPE       << GR
  EUROPE_EU    << GR
  EUROPE_EURO  << GR



end  # module WorldLite
