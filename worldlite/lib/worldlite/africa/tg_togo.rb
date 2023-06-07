# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Togo'
  c.key    = 'tg'
  c.alpha3 = 'TGO'
  c.fifa   = 'TOG'
  c.net    = 'tg'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Togo / Africa
  #    tags: africa, western africa, un, fifa, caf
  TG = c

  WORLD      << TG
  WORLD_UN   << TG
  WORLD_ISO  << TG
  WORLD_FIFA << TG




end  # module WorldLite
