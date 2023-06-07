# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Rwanda'
  c.key    = 'rw'
  c.alpha3 = 'RWA'
  c.fifa   = 'RWA'
  c.net    = 'rw'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Rwanda / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  RW = c

  WORLD      << RW
  WORLD_UN   << RW
  WORLD_ISO  << RW
  WORLD_FIFA << RW
  WORLD_COMMONWEALTH  << RW




end  # module WorldLite
