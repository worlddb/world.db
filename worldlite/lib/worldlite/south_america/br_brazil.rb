# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Brazil'
  c.key    = 'br'
  c.alpha3 = 'BRA'
  c.fifa   = 'BRA'
  c.net    = 'br'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Brazil / South America
  #    tags: south america, southern cone, un, g5, g20, fifa, conmebol
  BR = c

  WORLD      << BR
  WORLD_UN   << BR
  WORLD_ISO  << BR
  WORLD_FIFA << BR
  WORLD_G20  << BR




end  # module WorldLite
