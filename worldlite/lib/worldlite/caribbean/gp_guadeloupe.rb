# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Guadeloupe'
  c.key    = 'gp'
  c.alpha3 = 'GPE'
  c.fifa   = nil
  c.net    = 'gp'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Guadeloupe / Caribbean
  #    tags: caribbean, concacaf, concacaf cfu, territory
  GP = c

  WORLD      << GP
  WORLD_ISO  << GP




end  # module WorldLite
