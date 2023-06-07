# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Kitts and Nevis'
  c.key    = 'kn'
  c.alpha3 = 'KNA'
  c.fifa   = 'SKN'
  c.net    = 'kn'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Saint Kitts and Nevis / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  KN = c

  WORLD      << KN
  WORLD_UN   << KN
  WORLD_ISO  << KN
  WORLD_FIFA << KN
  WORLD_COMMONWEALTH  << KN




end  # module WorldLite
