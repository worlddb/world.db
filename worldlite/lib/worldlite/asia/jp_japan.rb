# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Japan'
  c.key    = 'jp'
  c.alpha3 = 'JPN'
  c.fifa   = 'JPN'
  c.net    = 'jp'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Japan / Asia
  #    tags: asia
  JP = c

  WORLD      << JP
  WORLD_ISO  << JP
  WORLD_FIFA << JP




end  # module WorldLite
