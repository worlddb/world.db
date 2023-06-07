# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Ecuador'
  c.key    = 'ec'
  c.alpha3 = 'ECU'
  c.fifa   = 'ECU'
  c.net    = 'ec'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Ecuador / South America
  #    tags: south america, andean states, un, fifa, conmebol
  EC = c

  WORLD      << EC
  WORLD_UN   << EC
  WORLD_ISO  << EC
  WORLD_FIFA << EC




end  # module WorldLite
