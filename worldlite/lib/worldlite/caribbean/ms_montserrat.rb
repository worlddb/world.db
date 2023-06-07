# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Montserrat'
  c.key    = 'ms'
  c.alpha3 = 'MSR'
  c.fifa   = nil
  c.net    = 'ms'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Montserrat / Caribbean
  #    tags: caribbean, territory
  MS = c

  WORLD      << MS
  WORLD_ISO  << MS




end  # module WorldLite
