# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Myanmar'
  c.key    = 'mm'
  c.alpha3 = 'MMR'
  c.fifa   = 'MYA'
  c.net    = 'mm'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Myanmar / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  MM = c

  WORLD      << MM
  WORLD_UN   << MM
  WORLD_ISO  << MM
  WORLD_FIFA << MM




end  # module WorldLite
