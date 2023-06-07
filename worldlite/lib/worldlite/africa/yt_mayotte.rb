# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Mayotte'
  c.key    = 'yt'
  c.alpha3 = 'MYT'
  c.fifa   = nil
  c.net    = 'yt'



  c.continent_name =  'Africa'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Mayotte / Africa
  #    tags: africa, territory
  YT = c

  WORLD      << YT
  WORLD_ISO  << YT




end  # module WorldLite
