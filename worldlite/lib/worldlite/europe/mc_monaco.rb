# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Monaco'
  c.key    = 'mc'
  c.alpha3 = 'MCO'
  c.fifa   = nil
  c.net    = 'mc'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Monaco / Europe
  #    tags: europe, western europe, un, microstate
  MC = c

  WORLD      << MC
  WORLD_UN   << MC
  WORLD_ISO  << MC
  WORLD_FIFA << MC

  EUROPE       << MC



end  # module WorldLite
