# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Afghanistan'
  c.key    = 'af'
  c.alpha3 = 'AFG'
  c.fifa   = 'AFG'
  c.net    = 'af'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Afghanistan / Asia
  #    tags: asia, un, fifa, afc, central asia, south asia
  AF = c

  WORLD      << AF
  WORLD_UN   << AF
  WORLD_ISO  << AF
  WORLD_FIFA << AF




end  # module WorldLite
