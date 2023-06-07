# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Mauritius'
  c.key    = 'mu'
  c.alpha3 = 'MUS'
  c.fifa   = 'MRI'
  c.net    = 'mu'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Mauritius / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  MU = c

  WORLD      << MU
  WORLD_UN   << MU
  WORLD_ISO  << MU
  WORLD_FIFA << MU
  WORLD_COMMONWEALTH  << MU




end  # module WorldLite
