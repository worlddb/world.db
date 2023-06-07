# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Timor-Leste'
  c.key    = 'tl'
  c.alpha3 = 'TLS'
  c.fifa   = 'TLS'
  c.net    = 'tl'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Timor-Leste [East Timor] / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  TL = c

  WORLD      << TL
  WORLD_UN   << TL
  WORLD_ISO  << TL
  WORLD_FIFA << TL




end  # module WorldLite
