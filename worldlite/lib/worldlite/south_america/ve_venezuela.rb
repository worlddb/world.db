# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Venezuela'
  c.key    = 've'
  c.alpha3 = 'VEN'
  c.fifa   = 'VEN'
  c.net    = 've'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Venezuela / South America
  #    tags: south america, andean states, un, fifa, conmebol
  VE = c

  WORLD      << VE
  WORLD_UN   << VE
  WORLD_ISO  << VE
  WORLD_FIFA << VE




end  # module WorldLite
