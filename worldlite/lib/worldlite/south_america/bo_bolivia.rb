# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bolivia'
  c.key    = 'bo'
  c.alpha3 = 'BOL'
  c.fifa   = 'BOL'
  c.net    = 'bo'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Bolivia / South America
  #    tags: south america, andean states, un, fifa, conmebol
  BO = c

  WORLD      << BO
  WORLD_UN   << BO
  WORLD_ISO  << BO
  WORLD_FIFA << BO




end  # module WorldLite
