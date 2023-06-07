# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Trinidad and Tobago'
  c.key    = 'tt'
  c.alpha3 = 'TTO'
  c.fifa   = 'TRI'
  c.net    = 'tt'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Trinidad and Tobago / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, concacaf cfu
  TT = c

  WORLD      << TT
  WORLD_UN   << TT
  WORLD_ISO  << TT
  WORLD_FIFA << TT
  WORLD_COMMONWEALTH  << TT




end  # module WorldLite
