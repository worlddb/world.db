# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Barbados'
  c.key    = 'bb'
  c.alpha3 = 'BRB'
  c.fifa   = 'BRB'
  c.net    = 'bb'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Barbados / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  BB = c

  WORLD      << BB
  WORLD_UN   << BB
  WORLD_ISO  << BB
  WORLD_FIFA << BB
  WORLD_COMMONWEALTH  << BB




end  # module WorldLite
