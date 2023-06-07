# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Dominica'
  c.key    = 'dm'
  c.alpha3 = 'DMA'
  c.fifa   = 'DMA'
  c.net    = 'dm'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Dominica / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  DM = c

  WORLD      << DM
  WORLD_UN   << DM
  WORLD_ISO  << DM
  WORLD_FIFA << DM
  WORLD_COMMONWEALTH  << DM




end  # module WorldLite
