# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saudi Arabia'
  c.key    = 'sa'
  c.alpha3 = 'SAU'
  c.fifa   = 'KSA'
  c.net    = 'sa'



  c.continent_name =  'Middle East'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Saudi Arabia / Middle East
  #    tags: middle east
  SA = c

  WORLD      << SA
  WORLD_ISO  << SA
  WORLD_FIFA << SA




end  # module WorldLite
