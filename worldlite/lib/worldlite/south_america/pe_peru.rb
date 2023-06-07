# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Peru'
  c.key    = 'pe'
  c.alpha3 = 'PER'
  c.fifa   = 'PER'
  c.net    = 'pe'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Peru / South America
  #    tags: south america, andean states, un, fifa, conmebol
  PE = c

  WORLD      << PE
  WORLD_UN   << PE
  WORLD_ISO  << PE
  WORLD_FIFA << PE




end  # module WorldLite
