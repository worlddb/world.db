# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Eritrea'
  c.key    = 'er'
  c.alpha3 = 'ERI'
  c.fifa   = 'ERI'
  c.net    = 'er'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Eritrea / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  ER = c

  WORLD      << ER
  WORLD_UN   << ER
  WORLD_ISO  << ER
  WORLD_FIFA << ER




end  # module WorldLite
