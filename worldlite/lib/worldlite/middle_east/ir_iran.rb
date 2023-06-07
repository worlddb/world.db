# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Iran'
  c.key    = 'ir'
  c.alpha3 = 'IRN'
  c.fifa   = 'IRN'
  c.net    = 'ir'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Iran / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff
  IR = c

  WORLD      << IR
  WORLD_UN   << IR
  WORLD_ISO  << IR
  WORLD_FIFA << IR




end  # module WorldLite
