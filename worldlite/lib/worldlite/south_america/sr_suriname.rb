# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Suriname'
  c.key    = 'sr'
  c.alpha3 = 'SUR'
  c.fifa   = 'SUR'
  c.net    = 'sr'



  c.continent_name =  'South America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Suriname / South America
  #    tags: south america, un, fifa, concacaf, concacaf cfu
  SR = c

  WORLD      << SR
  WORLD_UN   << SR
  WORLD_ISO  << SR
  WORLD_FIFA << SR




end  # module WorldLite
