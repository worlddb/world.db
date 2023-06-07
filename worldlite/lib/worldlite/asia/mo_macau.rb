# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Macau'
  c.key    = 'mo'
  c.alpha3 = 'MAC'
  c.fifa   = nil
  c.net    = 'mo'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Macau / Asia
  #    tags: asia, east asia, territory
  MO = c

  WORLD      << MO
  WORLD_ISO  << MO




end  # module WorldLite
