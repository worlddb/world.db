# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Libya'
  c.key    = 'ly'
  c.alpha3 = 'LBY'
  c.fifa   = 'LBY'
  c.net    = 'ly'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Libya / Africa
  #    tags: africa, northern africa, un, fifa, caf
  LY = c

  WORLD      << LY
  WORLD_UN   << LY
  WORLD_ISO  << LY
  WORLD_FIFA << LY




end  # module WorldLite
