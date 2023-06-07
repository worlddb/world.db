# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Comoros'
  c.key    = 'km'
  c.alpha3 = 'COM'
  c.fifa   = 'COM'
  c.net    = 'km'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Comoros / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  KM = c

  WORLD      << KM
  WORLD_UN   << KM
  WORLD_ISO  << KM
  WORLD_FIFA << KM




end  # module WorldLite
