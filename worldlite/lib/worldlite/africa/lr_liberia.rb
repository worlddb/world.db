# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Liberia'
  c.key    = 'lr'
  c.alpha3 = 'LBR'
  c.fifa   = 'LBR'
  c.net    = 'lr'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Liberia / Africa
  #    tags: africa, western africa, un, fifa, caf
  LR = c

  WORLD      << LR
  WORLD_UN   << LR
  WORLD_ISO  << LR
  WORLD_FIFA << LR




end  # module WorldLite
