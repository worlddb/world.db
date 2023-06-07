# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Northern Ireland'
  c.key    = 'nd'
  c.alpha3 = nil
  c.fifa   = 'NIR'
  c.net    = nil



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Northern Ireland / Europe
  #    tags: europe, northern europe, western europe, fifa, uefa, territory
  ND = c

  WORLD      << ND
  WORLD_ISO  << ND
  WORLD_FIFA << ND

  EUROPE       << ND



end  # module WorldLite
