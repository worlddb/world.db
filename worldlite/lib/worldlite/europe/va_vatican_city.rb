# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Vatican City'
  c.key    = 'va'
  c.alpha3 = 'VAT'
  c.fifa   = nil
  c.net    = 'va'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Vatican City / Europe
  #    tags: europe, southern europe, microstate
  VA = c

  WORLD      << VA
  WORLD_ISO  << VA
  WORLD_FIFA << VA

  EUROPE       << VA



end  # module WorldLite
