# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bangladesh'
  c.key    = 'bd'
  c.alpha3 = 'BGD'
  c.fifa   = 'BAN'
  c.net    = 'bd'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Bangladesh / Asia
  #    tags: asia, un, commonwealth, fifa, afc, south asia
  BD = c

  WORLD      << BD
  WORLD_UN   << BD
  WORLD_ISO  << BD
  WORLD_FIFA << BD
  WORLD_COMMONWEALTH  << BD




end  # module WorldLite
