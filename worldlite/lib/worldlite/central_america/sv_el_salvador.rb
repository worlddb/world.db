# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'El Salvador'
  c.key    = 'sv'
  c.alpha3 = 'SLV'
  c.fifa   = 'SLV'
  c.net    = 'sv'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  El Salvador / Central America
  #    tags: central america, un, fifa, concacaf, concacaf uncaf
  SV = c

  WORLD      << SV
  WORLD_UN   << SV
  WORLD_ISO  << SV
  WORLD_FIFA << SV




end  # module WorldLite
