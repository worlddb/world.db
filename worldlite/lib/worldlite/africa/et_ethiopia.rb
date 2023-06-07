# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Ethiopia'
  c.key    = 'et'
  c.alpha3 = 'ETH'
  c.fifa   = 'ETH'
  c.net    = 'et'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Ethiopia / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  ET = c

  WORLD      << ET
  WORLD_UN   << ET
  WORLD_ISO  << ET
  WORLD_FIFA << ET




end  # module WorldLite
