# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Croatia'
  c.key    = 'hr'
  c.alpha3 = 'HRV'
  c.fifa   = 'CRO'
  c.net    = 'hr'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Croatia / Europe
  #    tags: europe, southern europe, southeastern europe, balkans, un, fifa, uefa
  HR = c

  WORLD      << HR
  WORLD_UN   << HR
  WORLD_ISO  << HR
  WORLD_FIFA << HR

  EUROPE       << HR



end  # module WorldLite
