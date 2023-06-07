# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Grenada'
  c.key    = 'gd'
  c.alpha3 = 'GRD'
  c.fifa   = 'GRN'
  c.net    = 'gd'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Grenada / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  GD = c

  WORLD      << GD
  WORLD_UN   << GD
  WORLD_ISO  << GD
  WORLD_FIFA << GD
  WORLD_COMMONWEALTH  << GD




end  # module WorldLite
