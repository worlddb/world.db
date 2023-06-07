# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Egypt'
  c.key    = 'eg'
  c.alpha3 = 'EGY'
  c.fifa   = 'EGY'
  c.net    = 'eg'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Egypt / Africa
  #    tags: africa, northern africa, middle east, un, fifa, caf
  EG = c

  WORLD      << EG
  WORLD_UN   << EG
  WORLD_ISO  << EG
  WORLD_FIFA << EG




end  # module WorldLite
