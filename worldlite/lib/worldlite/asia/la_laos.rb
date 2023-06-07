# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Laos'
  c.key    = 'la'
  c.alpha3 = 'LAO'
  c.fifa   = 'LAO'
  c.net    = 'la'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Laos / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  LA = c

  WORLD      << LA
  WORLD_UN   << LA
  WORLD_ISO  << LA
  WORLD_FIFA << LA




end  # module WorldLite
