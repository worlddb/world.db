# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'England'
  c.key    = 'en'
  c.alpha3 = nil
  c.fifa   = 'ENG'
  c.net    = nil



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  England / Europe
  #    tags: europe, northern europe, western europe, fifa, uefa, territory
  EN = c

  WORLD      << EN
  WORLD_ISO  << EN
  WORLD_FIFA << EN

  EUROPE       << EN



end  # module WorldLite
