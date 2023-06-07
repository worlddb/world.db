# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Malaysia'
  c.key    = 'my'
  c.alpha3 = 'MYS'
  c.fifa   = 'MAS'
  c.net    = 'my'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Malaysia / Asia
  #    tags: asia, un, commonwealth, fifa, afc, southeast asia
  MY = c

  WORLD      << MY
  WORLD_UN   << MY
  WORLD_ISO  << MY
  WORLD_FIFA << MY
  WORLD_COMMONWEALTH  << MY




end  # module WorldLite
