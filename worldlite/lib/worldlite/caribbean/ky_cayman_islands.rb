# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cayman Islands'
  c.key    = 'ky'
  c.alpha3 = 'CYM'
  c.fifa   = nil
  c.net    = 'ky'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Cayman Islands / Caribbean
  #    tags: caribbean, territory
  KY = c

  WORLD      << KY
  WORLD_ISO  << KY




end  # module WorldLite
