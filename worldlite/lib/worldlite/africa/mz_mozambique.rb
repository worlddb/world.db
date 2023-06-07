# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Mozambique'
  c.key    = 'mz'
  c.alpha3 = 'MOZ'
  c.fifa   = 'MOZ'
  c.net    = 'mz'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Mozambique / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  MZ = c

  WORLD      << MZ
  WORLD_UN   << MZ
  WORLD_ISO  << MZ
  WORLD_FIFA << MZ
  WORLD_COMMONWEALTH  << MZ




end  # module WorldLite
