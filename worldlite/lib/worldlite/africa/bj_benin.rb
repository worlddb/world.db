# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Benin'
  c.key    = 'bj'
  c.alpha3 = 'BEN'
  c.fifa   = 'BEN'
  c.net    = 'bj'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Benin / Africa
  #    tags: africa, western africa, un, fifa, caf
  BJ = c

  WORLD      << BJ
  WORLD_UN   << BJ
  WORLD_ISO  << BJ
  WORLD_FIFA << BJ




end  # module WorldLite
