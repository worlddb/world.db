# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Thailand'
  c.key    = 'th'
  c.alpha3 = 'THA'
  c.fifa   = 'THA'
  c.net    = 'th'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Thailand / Asia
  #    tags: asia, un, fifa, afc, southeast asia
  TH = c

  WORLD      << TH
  WORLD_UN   << TH
  WORLD_ISO  << TH
  WORLD_FIFA << TH




end  # module WorldLite
