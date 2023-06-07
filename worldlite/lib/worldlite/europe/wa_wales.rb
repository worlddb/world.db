# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Wales'
  c.key    = 'wa'
  c.alpha3 = nil
  c.fifa   = 'WAL'
  c.net    = nil



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Wales / Europe
  #    tags: europe, northern europe, western europe, fifa, uefa, territory
  WA = c

  WORLD      << WA
  WORLD_ISO  << WA
  WORLD_FIFA << WA

  EUROPE       << WA



end  # module WorldLite
