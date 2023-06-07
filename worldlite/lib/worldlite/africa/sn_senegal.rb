# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Senegal'
  c.key    = 'sn'
  c.alpha3 = 'SEN'
  c.fifa   = 'SEN'
  c.net    = 'sn'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Senegal / Africa
  #    tags: africa, western africa, un, fifa, caf
  SN = c

  WORLD      << SN
  WORLD_UN   << SN
  WORLD_ISO  << SN
  WORLD_FIFA << SN




end  # module WorldLite
