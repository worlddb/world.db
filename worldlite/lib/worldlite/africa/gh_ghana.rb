# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Ghana'
  c.key    = 'gh'
  c.alpha3 = 'GHA'
  c.fifa   = 'GHA'
  c.net    = 'gh'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Ghana / Africa
  #    tags: africa, western africa, un, commonwealth, fifa, caf
  GH = c

  WORLD      << GH
  WORLD_UN   << GH
  WORLD_ISO  << GH
  WORLD_FIFA << GH
  WORLD_COMMONWEALTH  << GH




end  # module WorldLite
