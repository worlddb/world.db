# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Namibia'
  c.key    = 'na'
  c.alpha3 = 'NAM'
  c.fifa   = 'NAM'
  c.net    = 'na'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Namibia / Africa
  #    tags: africa, southern africa, un, commonwealth, fifa, caf
  NA = c

  WORLD      << NA
  WORLD_UN   << NA
  WORLD_ISO  << NA
  WORLD_FIFA << NA
  WORLD_COMMONWEALTH  << NA




end  # module WorldLite
