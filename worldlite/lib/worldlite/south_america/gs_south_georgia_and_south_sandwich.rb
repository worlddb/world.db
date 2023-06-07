# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'South Georgia and South Sandwich'
  c.key    = 'gs'
  c.alpha3 = 'SGS'
  c.fifa   = nil
  c.net    = 'gs'



  c.continent_name =  'South America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  South Georgia and South Sandwich / South America
  #    tags: south america, territory
  GS = c

  WORLD      << GS
  WORLD_ISO  << GS




end  # module WorldLite
