# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'South Korea'
  c.key    = 'kr'
  c.alpha3 = 'KOR'
  c.fifa   = 'KOR'
  c.net    = 'kr'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  South Korea / Asia
  #    tags: asia
  KR = c

  WORLD      << KR
  WORLD_ISO  << KR
  WORLD_FIFA << KR




end  # module WorldLite
