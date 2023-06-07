# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Somalia'
  c.key    = 'so'
  c.alpha3 = 'SOM'
  c.fifa   = 'SOM'
  c.net    = 'so'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Somalia / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  SO = c

  WORLD      << SO
  WORLD_UN   << SO
  WORLD_ISO  << SO
  WORLD_FIFA << SO




end  # module WorldLite
