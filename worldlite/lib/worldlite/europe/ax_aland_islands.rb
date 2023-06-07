# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Åland Islands'
  c.key    = 'ax'
  c.alpha3 = 'ALA'
  c.fifa   = nil
  c.net    = 'ax'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Åland Islands / Europe
  #    tags: europe, northern europe, nordic, territory
  AX = c

  WORLD      << AX
  WORLD_ISO  << AX

  EUROPE       << AX



end  # module WorldLite
