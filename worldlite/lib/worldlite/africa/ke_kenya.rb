# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Kenya'
  c.key    = 'ke'
  c.alpha3 = 'KEN'
  c.fifa   = 'KEN'
  c.net    = 'ke'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Kenya / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  KE = c

  WORLD      << KE
  WORLD_UN   << KE
  WORLD_ISO  << KE
  WORLD_FIFA << KE
  WORLD_COMMONWEALTH  << KE




end  # module WorldLite
