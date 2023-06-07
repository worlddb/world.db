# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Switzerland'
  c.key    = 'ch'
  c.alpha3 = 'CHE'
  c.fifa   = 'SUI'
  c.net    = 'ch'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Switzerland / Europe
  #    tags: europe, western europe, central europe, un, fifa, uefa, schengen
  CH = c

  WORLD      << CH
  WORLD_UN   << CH
  WORLD_ISO  << CH
  WORLD_FIFA << CH

  EUROPE       << CH



end  # module WorldLite
