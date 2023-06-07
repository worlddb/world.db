# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bahamas'
  c.key    = 'bs'
  c.alpha3 = 'BHS'
  c.fifa   = 'BAH'
  c.net    = 'bs'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Bahamas / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, concacaf cfu
  BS = c

  WORLD      << BS
  WORLD_UN   << BS
  WORLD_ISO  << BS
  WORLD_FIFA << BS
  WORLD_COMMONWEALTH  << BS




end  # module WorldLite
