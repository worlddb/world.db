# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Palestine'
  c.key    = 'ps'
  c.alpha3 = 'PSE'
  c.fifa   = 'PLE'
  c.net    = 'ps'



  c.continent_name =  'Middle East'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Palestine / Middle East
  #    tags: middle east, fifa, afc, western asia, afc waff, fertile crescent
  PS = c

  WORLD      << PS
  WORLD_ISO  << PS
  WORLD_FIFA << PS




end  # module WorldLite
