# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Iceland'
  c.key    = 'is'
  c.alpha3 = 'ISL'
  c.fifa   = 'ISL'
  c.net    = 'is'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Iceland / Europe
  #    tags: europe, northern europe, nordic, un, fifa, uefa, schengen
  IS = c

  WORLD      << IS
  WORLD_UN   << IS
  WORLD_ISO  << IS
  WORLD_FIFA << IS

  EUROPE       << IS



end  # module WorldLite
