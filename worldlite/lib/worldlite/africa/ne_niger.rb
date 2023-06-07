# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Niger'
  c.key    = 'ne'
  c.alpha3 = 'NER'
  c.fifa   = 'NIG'
  c.net    = 'ne'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Niger / Africa
  #    tags: africa, western africa, un, fifa, caf
  NE = c

  WORLD      << NE
  WORLD_UN   << NE
  WORLD_ISO  << NE
  WORLD_FIFA << NE




end  # module WorldLite
