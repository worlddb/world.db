# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Algeria'
  c.key    = 'dz'
  c.alpha3 = 'DZA'
  c.fifa   = 'ALG'
  c.net    = 'dz'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Algeria / Africa
  #    tags: africa, northern africa, un, fifa, caf
  DZ = c

  WORLD      << DZ
  WORLD_UN   << DZ
  WORLD_ISO  << DZ
  WORLD_FIFA << DZ




end  # module WorldLite
