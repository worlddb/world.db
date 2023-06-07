# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Italy'
  c.key    = 'it'
  c.alpha3 = 'ITA'
  c.fifa   = 'ITA'
  c.net    = 'it'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Italy / Europe
  #    tags: europe, southern europe, un, g8, g20, eu, fifa, uefa, euro, schengen
  IT = c

  WORLD      << IT
  WORLD_UN   << IT
  WORLD_ISO  << IT
  WORLD_FIFA << IT
  WORLD_G8   << IT
  WORLD_G20  << IT

  EUROPE       << IT
  EUROPE_EU    << IT
  EUROPE_EURO  << IT



end  # module WorldLite
