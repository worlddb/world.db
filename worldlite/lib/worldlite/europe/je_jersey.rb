# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Jersey'
  c.key    = 'je'
  c.alpha3 = 'JEY'
  c.fifa   = nil
  c.net    = 'je'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Jersey / Europe
  #    tags: europe, western europe, territory
  JE = c

  WORLD      << JE
  WORLD_ISO  << JE

  EUROPE       << JE



end  # module WorldLite
