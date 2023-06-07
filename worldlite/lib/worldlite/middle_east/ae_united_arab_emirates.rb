# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'United Arab Emirates'
  c.key    = 'ae'
  c.alpha3 = 'ARE'
  c.fifa   = 'UAE'
  c.net    = 'ae'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  United Arab Emirates / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, arabian peninsula
  AE = c

  WORLD      << AE
  WORLD_UN   << AE
  WORLD_ISO  << AE
  WORLD_FIFA << AE




end  # module WorldLite
