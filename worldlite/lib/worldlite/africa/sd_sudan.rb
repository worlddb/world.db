# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Sudan'
  c.key    = 'sd'
  c.alpha3 = 'SDN'
  c.fifa   = 'SDN'
  c.net    = 'sd'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Sudan / Africa
  #    tags: africa, northern africa, un, fifa, caf
  SD = c

  WORLD      << SD
  WORLD_UN   << SD
  WORLD_ISO  << SD
  WORLD_FIFA << SD




end  # module WorldLite
