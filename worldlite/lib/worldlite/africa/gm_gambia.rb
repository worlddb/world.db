# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Gambia'
  c.key    = 'gm'
  c.alpha3 = 'GMB'
  c.fifa   = 'GAM'
  c.net    = 'gm'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Gambia / Africa
  #    tags: africa, western africa, un, commonwealth, fifa, caf
  GM = c

  WORLD      << GM
  WORLD_UN   << GM
  WORLD_ISO  << GM
  WORLD_FIFA << GM
  WORLD_COMMONWEALTH  << GM




end  # module WorldLite
