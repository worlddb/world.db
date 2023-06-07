# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'United States'
  c.key    = 'us'
  c.alpha3 = 'USA'
  c.fifa   = 'USA'
  c.net    = 'us'



  c.continent_name =  'North America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  United States / North America
  #    tags: north america
  US = c

  WORLD      << US
  WORLD_ISO  << US
  WORLD_FIFA << US




end  # module WorldLite
