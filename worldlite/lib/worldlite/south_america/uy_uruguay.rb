# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Uruguay'
  c.key    = 'uy'
  c.alpha3 = 'URY'
  c.fifa   = 'URU'
  c.net    = 'uy'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Uruguay / South America
  #    tags: south america, southern cone, un, fifa, conmebol
  UY = c

  WORLD      << UY
  WORLD_UN   << UY
  WORLD_ISO  << UY
  WORLD_FIFA << UY




end  # module WorldLite
