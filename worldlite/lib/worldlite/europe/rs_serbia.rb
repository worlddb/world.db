# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Serbia'
  c.key    = 'rs'
  c.alpha3 = 'SRB'
  c.fifa   = 'SRB'
  c.net    = 'rs'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Serbia / Europe
  #    tags: europe, southern europe, southeastern europe, balkans, un, fifa, uefa
  RS = c

  WORLD      << RS
  WORLD_UN   << RS
  WORLD_ISO  << RS
  WORLD_FIFA << RS

  EUROPE       << RS



end  # module WorldLite
