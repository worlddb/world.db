# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'México'
  c.key    = 'mx'
  c.alpha3 = 'MEX'
  c.fifa   = 'MEX'
  c.net    = 'mx'



  c.continent_name =  'North America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  México [Mexico] / North America
  #    tags: north america
  MX = c

  WORLD      << MX
  WORLD_ISO  << MX
  WORLD_FIFA << MX




end  # module WorldLite
