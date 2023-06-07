# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Norway'
  c.key    = 'no'
  c.alpha3 = 'NOR'
  c.fifa   = 'NOR'
  c.net    = 'no'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Norway / Europe
  #    tags: europe, northern europe, scandinavia, nordic, un, fifa, uefa, schengen
  NO = c

  WORLD      << NO
  WORLD_UN   << NO
  WORLD_ISO  << NO
  WORLD_FIFA << NO

  EUROPE       << NO



end  # module WorldLite
