# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Guinea'
  c.key    = 'gn'
  c.alpha3 = 'GIN'
  c.fifa   = 'GUI'
  c.net    = 'gn'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Guinea / Africa
  #    tags: africa, western africa, un, fifa, caf
  GN = c

  WORLD      << GN
  WORLD_UN   << GN
  WORLD_ISO  << GN
  WORLD_FIFA << GN




end  # module WorldLite
