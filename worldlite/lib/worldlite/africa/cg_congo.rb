# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Congo'
  c.key    = 'cg'
  c.alpha3 = 'COG'
  c.fifa   = 'CGO'
  c.net    = 'cg'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Congo / Africa
  #    tags: africa, central africa, un, fifa, caf
  CG = c

  WORLD      << CG
  WORLD_UN   << CG
  WORLD_ISO  << CG
  WORLD_FIFA << CG




end  # module WorldLite
