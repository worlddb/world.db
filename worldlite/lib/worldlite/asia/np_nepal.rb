# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Nepal'
  c.key    = 'np'
  c.alpha3 = 'NPL'
  c.fifa   = 'NEP'
  c.net    = 'np'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Nepal / Asia
  #    tags: asia, un, fifa, afc, south asia
  NP = c

  WORLD      << NP
  WORLD_UN   << NP
  WORLD_ISO  << NP
  WORLD_FIFA << NP




end  # module WorldLite
