# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Côte dIvoireIvoire'
  c.key    = 'ci'
  c.alpha3 = 'CIV'
  c.fifa   = 'CIV'
  c.net    = 'ci'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Côte d'Ivoire / Africa
  #    tags: africa, western africa, un, fifa, caf
  CI = c

  WORLD      << CI
  WORLD_UN   << CI
  WORLD_ISO  << CI
  WORLD_FIFA << CI




end  # module WorldLite
