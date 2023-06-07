# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Scotland'
  c.key    = 'sc'
  c.alpha3 = nil
  c.fifa   = 'SCO'
  c.net    = nil



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Scotland / Europe
  #    tags: europe, northern europe, western europe, fifa, uefa, territory
  SC = c

  WORLD      << SC
  WORLD_ISO  << SC
  WORLD_FIFA << SC

  EUROPE       << SC



end  # module WorldLite
