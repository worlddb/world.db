# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Honduras'
  c.key    = 'hn'
  c.alpha3 = 'HND'
  c.fifa   = 'HON'
  c.net    = 'hn'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Honduras / Central America
  #    tags: central america, un, fifa, concacaf, concacaf uncaf
  HN = c

  WORLD      << HN
  WORLD_UN   << HN
  WORLD_ISO  << HN
  WORLD_FIFA << HN




end  # module WorldLite
