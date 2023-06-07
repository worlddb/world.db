# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Curaçao'
  c.key    = 'cw'
  c.alpha3 = 'CUW'
  c.fifa   = nil
  c.net    = 'cw'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Curaçao / Caribbean
  #    tags: caribbean, territory
  CW = c

  WORLD      << CW
  WORLD_ISO  << CW




end  # module WorldLite
