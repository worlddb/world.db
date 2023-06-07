# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Haiti'
  c.key    = 'ht'
  c.alpha3 = 'HTI'
  c.fifa   = 'HAI'
  c.net    = 'ht'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Haiti / Caribbean
  #    tags: caribbean, un, fifa, concacaf, concacaf cfu
  HT = c

  WORLD      << HT
  WORLD_UN   << HT
  WORLD_ISO  << HT
  WORLD_FIFA << HT




end  # module WorldLite
