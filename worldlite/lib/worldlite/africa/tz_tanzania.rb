# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tanzania'
  c.key    = 'tz'
  c.alpha3 = 'TZA'
  c.fifa   = 'TAN'
  c.net    = 'tz'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Tanzania / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  TZ = c

  WORLD      << TZ
  WORLD_UN   << TZ
  WORLD_ISO  << TZ
  WORLD_FIFA << TZ
  WORLD_COMMONWEALTH  << TZ




end  # module WorldLite
