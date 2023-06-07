# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Australia'
  c.key    = 'au'
  c.alpha3 = 'AUS'
  c.fifa   = 'AUS'
  c.net    = 'au'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Australia / Pacific
  #    tags: un, g20, commonwealth, fifa, afc, pacific
  AU = c

  WORLD      << AU
  WORLD_UN   << AU
  WORLD_ISO  << AU
  WORLD_FIFA << AU
  WORLD_G20  << AU
  WORLD_COMMONWEALTH  << AU




end  # module WorldLite
