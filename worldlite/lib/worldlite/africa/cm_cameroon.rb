# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cameroon'
  c.key    = 'cm'
  c.alpha3 = 'CMR'
  c.fifa   = 'CMR'
  c.net    = 'cm'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Cameroon / Africa
  #    tags: africa, central africa, un, commonwealth, fifa, caf
  CM = c

  WORLD      << CM
  WORLD_UN   << CM
  WORLD_ISO  << CM
  WORLD_FIFA << CM
  WORLD_COMMONWEALTH  << CM




end  # module WorldLite
