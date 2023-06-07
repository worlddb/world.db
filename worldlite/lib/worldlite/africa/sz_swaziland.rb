# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Swaziland'
  c.key    = 'sz'
  c.alpha3 = 'SWZ'
  c.fifa   = 'SWZ'
  c.net    = 'sz'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Swaziland / Africa
  #    tags: africa, southern africa, un, commonwealth, fifa, caf
  SZ = c

  WORLD      << SZ
  WORLD_UN   << SZ
  WORLD_ISO  << SZ
  WORLD_FIFA << SZ
  WORLD_COMMONWEALTH  << SZ




end  # module WorldLite
