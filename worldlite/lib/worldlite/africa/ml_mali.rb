# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Mali'
  c.key    = 'ml'
  c.alpha3 = 'MLI'
  c.fifa   = 'MLI'
  c.net    = 'ml'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Mali / Africa
  #    tags: africa, western africa, un, fifa, caf
  ML = c

  WORLD      << ML
  WORLD_UN   << ML
  WORLD_ISO  << ML
  WORLD_FIFA << ML




end  # module WorldLite
