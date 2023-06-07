# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Canada'
  c.key    = 'ca'
  c.alpha3 = 'CAN'
  c.fifa   = 'CAN'
  c.net    = 'ca'



  c.continent_name =  'North America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Canada / North America
  #    tags: north america, un, g8, g20, commonwealth, fifa, concacaf, concacaf nafu
  CA = c

  WORLD      << CA
  WORLD_UN   << CA
  WORLD_ISO  << CA
  WORLD_FIFA << CA
  WORLD_G8   << CA
  WORLD_G20  << CA
  WORLD_COMMONWEALTH  << CA




end  # module WorldLite
