# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Moldova'
  c.key    = 'md'
  c.alpha3 = 'MDA'
  c.fifa   = 'MDA'
  c.net    = 'md'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Moldova / Europe
  #    tags: europe, eastern europe, un, fifa, uefa
  MD = c

  WORLD      << MD
  WORLD_UN   << MD
  WORLD_ISO  << MD
  WORLD_FIFA << MD

  EUROPE       << MD



end  # module WorldLite
