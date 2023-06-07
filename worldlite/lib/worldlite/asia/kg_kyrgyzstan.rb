# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Kyrgyzstan'
  c.key    = 'kg'
  c.alpha3 = 'KGZ'
  c.fifa   = 'KGZ'
  c.net    = 'kg'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Kyrgyzstan / Asia
  #    tags: asia, un, fifa, afc, central asia
  KG = c

  WORLD      << KG
  WORLD_UN   << KG
  WORLD_ISO  << KG
  WORLD_FIFA << KG




end  # module WorldLite
