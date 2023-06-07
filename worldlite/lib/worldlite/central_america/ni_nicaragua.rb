# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Nicaragua'
  c.key    = 'ni'
  c.alpha3 = 'NIC'
  c.fifa   = 'NCA'
  c.net    = 'ni'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Nicaragua / Central America
  #    tags: central america, un, fifa, concacaf, concacaf uncaf
  NI = c

  WORLD      << NI
  WORLD_UN   << NI
  WORLD_ISO  << NI
  WORLD_FIFA << NI




end  # module WorldLite
