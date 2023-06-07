# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'French Guiana'
  c.key    = 'gf'
  c.alpha3 = 'GUF'
  c.fifa   = nil
  c.net    = 'gf'



  c.continent_name =  'South America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  French Guiana / South America
  #    tags: south america, territory
  GF = c

  WORLD      << GF
  WORLD_ISO  << GF




end  # module WorldLite
