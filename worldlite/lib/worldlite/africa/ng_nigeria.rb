# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Nigeria'
  c.key    = 'ng'
  c.alpha3 = 'NGA'
  c.fifa   = 'NGA'
  c.net    = 'ng'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Nigeria / Africa
  #    tags: africa, western africa, un, commonwealth, fifa, caf
  NG = c

  WORLD      << NG
  WORLD_UN   << NG
  WORLD_ISO  << NG
  WORLD_FIFA << NG
  WORLD_COMMONWEALTH  << NG




end  # module WorldLite
