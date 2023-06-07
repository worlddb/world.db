# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Macedonia'
  c.key    = 'mk'
  c.alpha3 = 'MKD'
  c.fifa   = 'MKD'
  c.net    = 'mk'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Macedonia / Europe
  #    tags: europe, southern europe, southeastern europe, balkans, un, fifa, uefa
  MK = c

  WORLD      << MK
  WORLD_UN   << MK
  WORLD_ISO  << MK
  WORLD_FIFA << MK

  EUROPE       << MK



end  # module WorldLite
