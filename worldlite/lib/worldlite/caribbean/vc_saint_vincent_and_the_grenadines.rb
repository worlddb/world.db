# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Vincent and the Grenadines'
  c.key    = 'vc'
  c.alpha3 = 'VCT'
  c.fifa   = 'VIN'
  c.net    = 'vc'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Saint Vincent and the Grenadines / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  VC = c

  WORLD      << VC
  WORLD_UN   << VC
  WORLD_ISO  << VC
  WORLD_FIFA << VC
  WORLD_COMMONWEALTH  << VC




end  # module WorldLite
