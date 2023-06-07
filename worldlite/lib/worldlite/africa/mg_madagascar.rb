# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Madagascar'
  c.key    = 'mg'
  c.alpha3 = 'MDG'
  c.fifa   = 'MAD'
  c.net    = 'mg'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Madagascar / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  MG = c

  WORLD      << MG
  WORLD_UN   << MG
  WORLD_ISO  << MG
  WORLD_FIFA << MG




end  # module WorldLite
