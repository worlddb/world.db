# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Great Britain'
  c.key    = 'gb'
  c.alpha3 = 'GBR'
  c.fifa   = nil
  c.net    = 'uk'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Great Britain / Europe
  #    tags: europe, northern europe, western europe, un, g8, g20, eu, commonwealth
  GB = c

  WORLD      << GB
  WORLD_UN   << GB
  WORLD_ISO  << GB
  WORLD_FIFA << GB
  WORLD_G8   << GB
  WORLD_G20  << GB
  WORLD_COMMONWEALTH  << GB

  EUROPE       << GB
  EUROPE_EU    << GB



end  # module WorldLite
