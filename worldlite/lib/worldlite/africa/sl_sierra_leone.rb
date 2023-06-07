# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Sierra Leone'
  c.key    = 'sl'
  c.alpha3 = 'SLE'
  c.fifa   = 'SLE'
  c.net    = 'sl'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Sierra Leone / Africa
  #    tags: africa, western africa, un, commonwealth, fifa, caf
  SL = c

  WORLD      << SL
  WORLD_UN   << SL
  WORLD_ISO  << SL
  WORLD_FIFA << SL
  WORLD_COMMONWEALTH  << SL




end  # module WorldLite
