# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Vietnam'
  c.key    = 'vn'
  c.alpha3 = 'VNM'
  c.fifa   = 'VIE'
  c.net    = 'vn'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Vietnam / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  VN = c

  WORLD      << VN
  WORLD_UN   << VN
  WORLD_ISO  << VN
  WORLD_FIFA << VN




end  # module WorldLite
