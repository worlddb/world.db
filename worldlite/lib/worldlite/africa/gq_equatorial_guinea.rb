# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Equatorial Guinea'
  c.key    = 'gq'
  c.alpha3 = 'GNQ'
  c.fifa   = 'EQG'
  c.net    = 'gq'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Equatorial Guinea / Africa
  #    tags: africa, central africa, un, fifa, caf
  GQ = c

  WORLD      << GQ
  WORLD_UN   << GQ
  WORLD_ISO  << GQ
  WORLD_FIFA << GQ




end  # module WorldLite
