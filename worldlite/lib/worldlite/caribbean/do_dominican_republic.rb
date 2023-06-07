# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Dominican Republic'
  c.key    = 'do'
  c.alpha3 = 'DOM'
  c.fifa   = 'DOM'
  c.net    = 'do'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Dominican Republic / Caribbean
  #    tags: caribbean, un, fifa, concacaf, concacaf cfu
  DO = c

  WORLD      << DO
  WORLD_UN   << DO
  WORLD_ISO  << DO
  WORLD_FIFA << DO




end  # module WorldLite
