# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Yemen'
  c.key    = 'ye'
  c.alpha3 = 'YEM'
  c.fifa   = 'YEM'
  c.net    = 'ye'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Yemen / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, arabian peninsula
  YE = c

  WORLD      << YE
  WORLD_UN   << YE
  WORLD_ISO  << YE
  WORLD_FIFA << YE




end  # module WorldLite
