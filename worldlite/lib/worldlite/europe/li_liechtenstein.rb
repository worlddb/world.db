# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Liechtenstein'
  c.key    = 'li'
  c.alpha3 = 'LIE'
  c.fifa   = 'LIE'
  c.net    = 'li'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Liechtenstein / Europe
  #    tags: europe, western europe, un, fifa, uefa, microstate
  LI = c

  WORLD      << LI
  WORLD_UN   << LI
  WORLD_ISO  << LI
  WORLD_FIFA << LI

  EUROPE       << LI



end  # module WorldLite
