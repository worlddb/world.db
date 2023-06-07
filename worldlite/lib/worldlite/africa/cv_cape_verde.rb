# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cape Verde'
  c.key    = 'cv'
  c.alpha3 = 'CPV'
  c.fifa   = 'CPV'
  c.net    = 'cv'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Cape Verde / Africa
  #    tags: africa, western africa, un, fifa, caf
  CV = c

  WORLD      << CV
  WORLD_UN   << CV
  WORLD_ISO  << CV
  WORLD_FIFA << CV




end  # module WorldLite
