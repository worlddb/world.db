# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Congo DR'
  c.key    = 'cd'
  c.alpha3 = 'COD'
  c.fifa   = 'COD'
  c.net    = 'cd'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Congo DR / Africa
  #    tags: africa, central africa, un, fifa, caf
  CD = c

  WORLD      << CD
  WORLD_UN   << CD
  WORLD_ISO  << CD
  WORLD_FIFA << CD




end  # module WorldLite
