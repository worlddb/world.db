# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Burundi'
  c.key    = 'bi'
  c.alpha3 = 'BDI'
  c.fifa   = 'BDI'
  c.net    = 'bi'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Burundi / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  BI = c

  WORLD      << BI
  WORLD_UN   << BI
  WORLD_ISO  << BI
  WORLD_FIFA << BI




end  # module WorldLite
