# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Guatemala'
  c.key    = 'gt'
  c.alpha3 = 'GTM'
  c.fifa   = 'GUA'
  c.net    = 'gt'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Guatemala / Central America
  #    tags: central america, un, fifa, concacaf, concacaf uncaf
  GT = c

  WORLD      << GT
  WORLD_UN   << GT
  WORLD_ISO  << GT
  WORLD_FIFA << GT




end  # module WorldLite
