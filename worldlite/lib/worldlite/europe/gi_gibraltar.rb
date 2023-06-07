# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Gibraltar'
  c.key    = 'gi'
  c.alpha3 = 'GIB'
  c.fifa   = nil
  c.net    = 'gi'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Gibraltar / Europe
  #    tags: europe, southern europe, territory
  GI = c

  WORLD      << GI
  WORLD_ISO  << GI

  EUROPE       << GI



end  # module WorldLite
