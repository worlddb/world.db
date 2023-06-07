# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Jordan'
  c.key    = 'jo'
  c.alpha3 = 'JOR'
  c.fifa   = 'JOR'
  c.net    = 'jo'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Jordan / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, fertile crescent
  JO = c

  WORLD      << JO
  WORLD_UN   << JO
  WORLD_ISO  << JO
  WORLD_FIFA << JO




end  # module WorldLite
