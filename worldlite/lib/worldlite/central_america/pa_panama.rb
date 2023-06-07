# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Panamá'
  c.key    = 'pa'
  c.alpha3 = 'PAN'
  c.fifa   = 'PAN'
  c.net    = 'pa'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Panamá [Panama] / Central America
  #    tags: central america, un, fifa, concacaf, concacaf uncaf
  PA = c

  WORLD      << PA
  WORLD_UN   << PA
  WORLD_ISO  << PA
  WORLD_FIFA << PA




end  # module WorldLite
