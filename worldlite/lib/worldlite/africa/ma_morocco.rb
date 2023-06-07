# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Morocco'
  c.key    = 'ma'
  c.alpha3 = 'MAR'
  c.fifa   = 'MAR'
  c.net    = 'ma'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Morocco / Africa
  #    tags: africa, northern africa, un, fifa, caf
  MA = c

  WORLD      << MA
  WORLD_UN   << MA
  WORLD_ISO  << MA
  WORLD_FIFA << MA




end  # module WorldLite
