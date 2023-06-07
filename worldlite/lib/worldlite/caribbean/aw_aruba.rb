# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Aruba'
  c.key    = 'aw'
  c.alpha3 = 'ABW'
  c.fifa   = nil
  c.net    = 'aw'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Aruba / Caribbean
  #    tags: caribbean, territory
  AW = c

  WORLD      << AW
  WORLD_ISO  << AW




end  # module WorldLite
