# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'European Union'
  c.key    = 'eu'
  c.alpha3 = nil
  c.fifa   = nil
  c.net    = 'eu'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  European Union / Europe
  #    tags: europe, supra
  EU = c

  WORLD      << EU
  WORLD_ISO  << EU
  WORLD_FIFA << EU

  EUROPE       << EU



end  # module WorldLite
