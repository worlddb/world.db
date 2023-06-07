# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Sweden'
  c.key    = 'se'
  c.alpha3 = 'SWE'
  c.fifa   = 'SWE'
  c.net    = 'se'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Sweden / Europe
  #    tags: europe, northern europe, scandinavia, nordic, un, eu, fifa, uefa, schengen
  SE = c

  WORLD      << SE
  WORLD_UN   << SE
  WORLD_ISO  << SE
  WORLD_FIFA << SE

  EUROPE       << SE
  EUROPE_EU    << SE



end  # module WorldLite
