# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Greenland'
  c.key    = 'gl'
  c.alpha3 = 'GRL'
  c.fifa   = nil
  c.net    = 'gl'



  c.continent_name =  'North America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Greenland / North America
  #    tags: north america, territory
  GL = c

  WORLD      << GL
  WORLD_ISO  << GL




end  # module WorldLite
