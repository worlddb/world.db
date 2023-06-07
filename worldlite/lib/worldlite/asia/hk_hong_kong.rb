# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Hong Kong'
  c.key    = 'hk'
  c.alpha3 = 'HKG'
  c.fifa   = 'HKG'
  c.net    = 'hk'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Hong Kong / Asia
  #    tags: asia, fifa, afc, east asia, territory
  HK = c

  WORLD      << HK
  WORLD_ISO  << HK
  WORLD_FIFA << HK




end  # module WorldLite
