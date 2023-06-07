# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Armenia'
  c.key    = 'am'
  c.alpha3 = 'ARM'
  c.fifa   = 'ARM'
  c.net    = 'am'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Armenia / Europe
  #    tags: europe, un, fifa, uefa, western asia, south caucasus
  AM = c

  WORLD      << AM
  WORLD_UN   << AM
  WORLD_ISO  << AM
  WORLD_FIFA << AM

  EUROPE       << AM



end  # module WorldLite
