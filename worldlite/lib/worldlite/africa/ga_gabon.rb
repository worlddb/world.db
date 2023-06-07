# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Gabon'
  c.key    = 'ga'
  c.alpha3 = 'GAB'
  c.fifa   = 'GAB'
  c.net    = 'ga'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Gabon / Africa
  #    tags: africa, central africa, un, fifa, caf
  GA = c

  WORLD      << GA
  WORLD_UN   << GA
  WORLD_ISO  << GA
  WORLD_FIFA << GA




end  # module WorldLite
