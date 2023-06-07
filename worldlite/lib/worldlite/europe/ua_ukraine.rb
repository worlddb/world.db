# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Ukraine'
  c.key    = 'ua'
  c.alpha3 = 'UKR'
  c.fifa   = 'UKR'
  c.net    = 'ua'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Ukraine / Europe
  #    tags: europe, eastern europe, un, fifa, uefa
  UA = c

  WORLD      << UA
  WORLD_UN   << UA
  WORLD_ISO  << UA
  WORLD_FIFA << UA

  EUROPE       << UA



end  # module WorldLite
