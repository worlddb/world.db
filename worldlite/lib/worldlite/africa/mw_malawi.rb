# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Malawi'
  c.key    = 'mw'
  c.alpha3 = 'MWI'
  c.fifa   = 'MWI'
  c.net    = 'mw'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Malawi / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  MW = c

  WORLD      << MW
  WORLD_UN   << MW
  WORLD_ISO  << MW
  WORLD_FIFA << MW
  WORLD_COMMONWEALTH  << MW




end  # module WorldLite
