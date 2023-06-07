# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Guinea-Bissau'
  c.key    = 'gw'
  c.alpha3 = 'GNB'
  c.fifa   = 'GNB'
  c.net    = 'gw'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Guinea-Bissau / Africa
  #    tags: africa, western africa, un, fifa, caf
  GW = c

  WORLD      << GW
  WORLD_UN   << GW
  WORLD_ISO  << GW
  WORLD_FIFA << GW




end  # module WorldLite
