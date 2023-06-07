# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'South Sudan'
  c.key    = 'ss'
  c.alpha3 = 'SSD'
  c.fifa   = 'SSD'
  c.net    = 'ss'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  South Sudan / Africa
  #    tags: africa, northern africa, un, fifa, caf
  SS = c

  WORLD      << SS
  WORLD_UN   << SS
  WORLD_ISO  << SS
  WORLD_FIFA << SS




end  # module WorldLite
