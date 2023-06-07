# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Syria'
  c.key    = 'sy'
  c.alpha3 = 'SYR'
  c.fifa   = 'SYR'
  c.net    = 'sy'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Syria / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, fertile crescent
  SY = c

  WORLD      << SY
  WORLD_UN   << SY
  WORLD_ISO  << SY
  WORLD_FIFA << SY




end  # module WorldLite
