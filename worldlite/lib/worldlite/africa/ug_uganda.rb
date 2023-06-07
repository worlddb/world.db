# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Uganda'
  c.key    = 'ug'
  c.alpha3 = 'UGA'
  c.fifa   = 'UGA'
  c.net    = 'ug'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Uganda / Africa
  #    tags: africa, eastern africa, un, commonwealth, fifa, caf
  UG = c

  WORLD      << UG
  WORLD_UN   << UG
  WORLD_ISO  << UG
  WORLD_FIFA << UG
  WORLD_COMMONWEALTH  << UG




end  # module WorldLite
