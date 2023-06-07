# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cuba'
  c.key    = 'cu'
  c.alpha3 = 'CUB'
  c.fifa   = 'CUB'
  c.net    = 'cu'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Cuba / Caribbean
  #    tags: caribbean, un, fifa, concacaf, concacaf cfu
  CU = c

  WORLD      << CU
  WORLD_UN   << CU
  WORLD_ISO  << CU
  WORLD_FIFA << CU




end  # module WorldLite
