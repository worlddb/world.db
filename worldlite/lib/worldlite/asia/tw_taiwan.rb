# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Taiwan'
  c.key    = 'tw'
  c.alpha3 = 'TWN'
  c.fifa   = 'TPE'
  c.net    = 'tw'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Taiwan / Asia
  #    tags: asia, fifa, afc, east asia
  TW = c

  WORLD      << TW
  WORLD_ISO  << TW
  WORLD_FIFA << TW




end  # module WorldLite
