# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Zambia'
  c.key    = 'zm'
  c.alpha3 = 'ZMB'
  c.fifa   = 'ZAM'
  c.net    = 'zm'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Zambia / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  ZM = c

  WORLD      << ZM
  WORLD_UN   << ZM
  WORLD_ISO  << ZM
  WORLD_FIFA << ZM
  WORLD_COMMONWEALTH  << ZM




end  # module WorldLite
