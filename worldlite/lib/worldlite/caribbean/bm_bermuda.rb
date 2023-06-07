# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bermuda'
  c.key    = 'bm'
  c.alpha3 = 'BMU'
  c.fifa   = nil
  c.net    = 'bm'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Bermuda / Caribbean
  #    tags: caribbean, territory
  BM = c

  WORLD      << BM
  WORLD_ISO  << BM




end  # module WorldLite
