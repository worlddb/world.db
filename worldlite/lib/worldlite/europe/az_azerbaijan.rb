# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Azerbaijan'
  c.key    = 'az'
  c.alpha3 = 'AZE'
  c.fifa   = 'AZE'
  c.net    = 'az'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Azerbaijan / Europe
  #    tags: europe, un, fifa, uefa, western asia, south caucasus
  AZ = c

  WORLD      << AZ
  WORLD_UN   << AZ
  WORLD_ISO  << AZ
  WORLD_FIFA << AZ

  EUROPE       << AZ



end  # module WorldLite
