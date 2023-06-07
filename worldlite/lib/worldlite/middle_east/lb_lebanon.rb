# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Lebanon'
  c.key    = 'lb'
  c.alpha3 = 'LBN'
  c.fifa   = 'LIB'
  c.net    = 'lb'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Lebanon / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, fertile crescent
  LB = c

  WORLD      << LB
  WORLD_UN   << LB
  WORLD_ISO  << LB
  WORLD_FIFA << LB




end  # module WorldLite
