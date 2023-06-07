# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Burkina Faso'
  c.key    = 'bf'
  c.alpha3 = 'BFA'
  c.fifa   = 'BFA'
  c.net    = 'bf'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Burkina Faso / Africa
  #    tags: africa, western africa, un, fifa, caf
  BF = c

  WORLD      << BF
  WORLD_UN   << BF
  WORLD_ISO  << BF
  WORLD_FIFA << BF




end  # module WorldLite
