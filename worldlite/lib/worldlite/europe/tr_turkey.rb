# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Turkey'
  c.key    = 'tr'
  c.alpha3 = 'TUR'
  c.fifa   = 'TUR'
  c.net    = 'tr'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Turkey / Europe
  #    tags: europe
  TR = c

  WORLD      << TR
  WORLD_ISO  << TR
  WORLD_FIFA << TR

  EUROPE       << TR



end  # module WorldLite
