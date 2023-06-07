# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'British Indian Ocean Territory'
  c.key    = 'io'
  c.alpha3 = 'IOT'
  c.fifa   = nil
  c.net    = 'io'



  c.continent_name =  'Asia'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  British Indian Ocean Territory / Asia
  #    tags: asia, territory
  IO = c

  WORLD      << IO
  WORLD_ISO  << IO




end  # module WorldLite
