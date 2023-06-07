# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Jamaica'
  c.key    = 'jm'
  c.alpha3 = 'JAM'
  c.fifa   = 'JAM'
  c.net    = 'jm'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Jamaica / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, concacaf cfu
  JM = c

  WORLD      << JM
  WORLD_UN   << JM
  WORLD_ISO  << JM
  WORLD_FIFA << JM
  WORLD_COMMONWEALTH  << JM




end  # module WorldLite
