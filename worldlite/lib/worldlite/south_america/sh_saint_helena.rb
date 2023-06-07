# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Helena'
  c.key    = 'sh'
  c.alpha3 = 'SHN'
  c.fifa   = nil
  c.net    = 'sh'



  c.continent_name =  'South America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Saint Helena / South America
  #    tags: south america, territory
  SH = c

  WORLD      << SH
  WORLD_ISO  << SH




end  # module WorldLite
