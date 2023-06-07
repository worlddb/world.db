# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tunisia'
  c.key    = 'tn'
  c.alpha3 = 'TUN'
  c.fifa   = 'TUN'
  c.net    = 'tn'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Tunisia / Africa
  #    tags: africa, northern africa, un, fifa, caf
  TN = c

  WORLD      << TN
  WORLD_UN   << TN
  WORLD_ISO  << TN
  WORLD_FIFA << TN




end  # module WorldLite
