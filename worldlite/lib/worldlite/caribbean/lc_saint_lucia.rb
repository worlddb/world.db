# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Lucia'
  c.key    = 'lc'
  c.alpha3 = 'LCA'
  c.fifa   = 'LCA'
  c.net    = 'lc'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Saint Lucia / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  LC = c

  WORLD      << LC
  WORLD_UN   << LC
  WORLD_ISO  << LC
  WORLD_FIFA << LC
  WORLD_COMMONWEALTH  << LC




end  # module WorldLite
