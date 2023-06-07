# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Paraguay'
  c.key    = 'py'
  c.alpha3 = 'PRY'
  c.fifa   = 'PAR'
  c.net    = 'py'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Paraguay / South America
  #    tags: south america, southern cone, un, fifa, conmebol
  PY = c

  WORLD      << PY
  WORLD_UN   << PY
  WORLD_ISO  << PY
  WORLD_FIFA << PY




end  # module WorldLite
