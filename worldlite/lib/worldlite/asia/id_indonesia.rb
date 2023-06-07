# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Indonesia'
  c.key    = 'id'
  c.alpha3 = 'IDN'
  c.fifa   = 'IDN'
  c.net    = 'id'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Indonesia / Asia
  #    tags: asia
  ID = c

  WORLD      << ID
  WORLD_ISO  << ID
  WORLD_FIFA << ID




end  # module WorldLite
