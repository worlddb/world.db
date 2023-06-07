# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Mauritania'
  c.key    = 'mr'
  c.alpha3 = 'MRT'
  c.fifa   = 'MTN'
  c.net    = 'mr'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Mauritania / Africa
  #    tags: africa, western africa, un, fifa, caf
  MR = c

  WORLD      << MR
  WORLD_UN   << MR
  WORLD_ISO  << MR
  WORLD_FIFA << MR




end  # module WorldLite
