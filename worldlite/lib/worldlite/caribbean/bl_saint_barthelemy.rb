# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Barthélemy'
  c.key    = 'bl'
  c.alpha3 = 'BLM'
  c.fifa   = nil
  c.net    = 'bl'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Saint Barthélemy / Caribbean
  #    tags: caribbean, territory
  BL = c

  WORLD      << BL
  WORLD_ISO  << BL




end  # module WorldLite
