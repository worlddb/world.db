# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Zimbabwe'
  c.key    = 'zw'
  c.alpha3 = 'ZWE'
  c.fifa   = 'ZIM'
  c.net    = 'zw'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Zimbabwe / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  ZW = c

  WORLD      << ZW
  WORLD_UN   << ZW
  WORLD_ISO  << ZW
  WORLD_FIFA << ZW




end  # module WorldLite
