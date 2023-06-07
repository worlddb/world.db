# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bahrain'
  c.key    = 'bh'
  c.alpha3 = 'BHR'
  c.fifa   = 'BHR'
  c.net    = 'bh'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Bahrain / Middle East
  #    tags: middle east, un, fifa, afc, microstate, western asia, afc waff, arabian peninsula
  BH = c

  WORLD      << BH
  WORLD_UN   << BH
  WORLD_ISO  << BH
  WORLD_FIFA << BH




end  # module WorldLite
