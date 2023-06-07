# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Russia'
  c.key    = 'ru'
  c.alpha3 = 'RUS'
  c.fifa   = 'RUS'
  c.net    = 'ru'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Russia / Europe
  #    tags: europe
  RU = c

  WORLD      << RU
  WORLD_ISO  << RU
  WORLD_FIFA << RU

  EUROPE       << RU



end  # module WorldLite
