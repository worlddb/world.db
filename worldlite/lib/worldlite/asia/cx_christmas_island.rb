# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Christmas Island'
  c.key    = 'cx'
  c.alpha3 = 'CXR'
  c.fifa   = nil
  c.net    = 'cx'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Christmas Island / Asia
  #    tags: asia, territory
  CX = c

  WORLD      << CX
  WORLD_ISO  << CX




end  # module WorldLite
