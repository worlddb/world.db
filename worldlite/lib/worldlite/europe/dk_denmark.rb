# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Denmark'
  c.key    = 'dk'
  c.alpha3 = 'DNK'
  c.fifa   = 'DEN'
  c.net    = 'dk'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Denmark / Europe
  #    tags: europe, northern europe, scandinavia, nordic, un, eu, fifa, uefa, schengen
  DK = c

  WORLD      << DK
  WORLD_UN   << DK
  WORLD_ISO  << DK
  WORLD_FIFA << DK

  EUROPE       << DK
  EUROPE_EU    << DK



end  # module WorldLite
