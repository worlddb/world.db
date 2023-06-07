# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cambodia'
  c.key    = 'kh'
  c.alpha3 = 'KHM'
  c.fifa   = 'CAM'
  c.net    = 'kh'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Cambodia / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  KH = c

  WORLD      << KH
  WORLD_UN   << KH
  WORLD_ISO  << KH
  WORLD_FIFA << KH




end  # module WorldLite
