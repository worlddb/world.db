# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Colombia'
  c.key    = 'co'
  c.alpha3 = 'COL'
  c.fifa   = 'COL'
  c.net    = 'co'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Colombia / South America
  #    tags: south america, andean states, un, fifa, conmebol
  CO = c

  WORLD      << CO
  WORLD_UN   << CO
  WORLD_ISO  << CO
  WORLD_FIFA << CO




end  # module WorldLite
