# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Belarus'
  c.key    = 'by'
  c.alpha3 = 'BLR'
  c.fifa   = 'BLR'
  c.net    = 'by'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Belarus / Europe
  #    tags: europe, eastern europe, un, fifa, uefa
  BY = c

  WORLD      << BY
  WORLD_UN   << BY
  WORLD_ISO  << BY
  WORLD_FIFA << BY

  EUROPE       << BY



end  # module WorldLite
