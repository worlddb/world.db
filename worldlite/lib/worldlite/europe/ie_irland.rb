# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Irland'
  c.key    = 'ie'
  c.alpha3 = 'IRL'
  c.fifa   = 'IRL'
  c.net    = 'ie'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Irland / Europe
  #    tags: europe, northern europe, western europe, un, eu, fifa, uefa, euro
  IE = c

  WORLD      << IE
  WORLD_UN   << IE
  WORLD_ISO  << IE
  WORLD_FIFA << IE

  EUROPE       << IE
  EUROPE_EU    << IE
  EUROPE_EURO  << IE



end  # module WorldLite
