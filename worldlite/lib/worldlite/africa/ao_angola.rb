# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Angola'
  c.key    = 'ao'
  c.alpha3 = 'AGO'
  c.fifa   = 'ANG'
  c.net    = 'ao'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Angola / Africa
  #    tags: africa, central africa, un, fifa, caf
  AO = c

  WORLD      << AO
  WORLD_UN   << AO
  WORLD_ISO  << AO
  WORLD_FIFA << AO




end  # module WorldLite
