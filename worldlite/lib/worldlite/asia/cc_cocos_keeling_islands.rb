# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cocos (Keeling) Islands'
  c.key    = 'cc'
  c.alpha3 = 'CCK'
  c.fifa   = nil
  c.net    = 'cc'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Cocos (Keeling) Islands / Asia
  #    tags: asia, territory
  CC = c

  WORLD      << CC
  WORLD_ISO  << CC




end  # module WorldLite
