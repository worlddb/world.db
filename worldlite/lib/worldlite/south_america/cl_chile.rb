# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Chile'
  c.key    = 'cl'
  c.alpha3 = 'CHL'
  c.fifa   = 'CHI'
  c.net    = 'cl'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Chile / South America
  #    tags: south america, southern cone, un, fifa, conmebol
  CL = c

  WORLD      << CL
  WORLD_UN   << CL
  WORLD_ISO  << CL
  WORLD_FIFA << CL




end  # module WorldLite
