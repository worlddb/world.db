# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Romania'
  c.key    = 'ro'
  c.alpha3 = 'ROU'
  c.fifa   = 'ROU'
  c.net    = 'ro'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Romania / Europe
  #    tags: europe, eastern europe, southeastern europe, un, eu, fifa, uefa
  RO = c

  WORLD      << RO
  WORLD_UN   << RO
  WORLD_ISO  << RO
  WORLD_FIFA << RO

  EUROPE       << RO
  EUROPE_EU    << RO



end  # module WorldLite
