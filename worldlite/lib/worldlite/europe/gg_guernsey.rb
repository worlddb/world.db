# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Guernsey'
  c.key    = 'gg'
  c.alpha3 = 'GGY'
  c.fifa   = nil
  c.net    = 'gg'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Guernsey / Europe
  #    tags: europe, western europe, territory
  GG = c

  WORLD      << GG
  WORLD_ISO  << GG

  EUROPE       << GG



end  # module WorldLite
