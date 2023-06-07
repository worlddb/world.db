# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Puerto Rico'
  c.key    = 'pr'
  c.alpha3 = 'PUR'
  c.fifa   = 'PUR'
  c.net    = 'pr'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Puerto Rico / Caribbean
  #    tags: caribbean, fifa, concacaf, concacaf cfu, territory
  PR = c

  WORLD      << PR
  WORLD_ISO  << PR
  WORLD_FIFA << PR




end  # module WorldLite
