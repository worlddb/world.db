# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Kuwait'
  c.key    = 'kw'
  c.alpha3 = 'KWT'
  c.fifa   = 'KUW'
  c.net    = 'kw'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Kuwait / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, arabian peninsula
  KW = c

  WORLD      << KW
  WORLD_UN   << KW
  WORLD_ISO  << KW
  WORLD_FIFA << KW




end  # module WorldLite
