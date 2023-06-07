# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Lesotho'
  c.key    = 'ls'
  c.alpha3 = 'LSO'
  c.fifa   = 'LES'
  c.net    = 'ls'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Lesotho / Africa
  #    tags: africa, southern africa, un, commonwealth, fifa, caf
  LS = c

  WORLD      << LS
  WORLD_UN   << LS
  WORLD_ISO  << LS
  WORLD_FIFA << LS
  WORLD_COMMONWEALTH  << LS




end  # module WorldLite
