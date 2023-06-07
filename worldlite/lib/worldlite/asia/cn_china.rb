# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'China'
  c.key    = 'cn'
  c.alpha3 = 'CHN'
  c.fifa   = 'CHN'
  c.net    = 'cn'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  China / Asia
  #    tags: asia
  CN = c

  WORLD      << CN
  WORLD_ISO  << CN
  WORLD_FIFA << CN




end  # module WorldLite
