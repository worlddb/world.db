# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Iraq'
  c.key    = 'iq'
  c.alpha3 = 'IRQ'
  c.fifa   = 'IRQ'
  c.net    = 'iq'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Iraq / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, fertile crescent
  IQ = c

  WORLD      << IQ
  WORLD_UN   << IQ
  WORLD_ISO  << IQ
  WORLD_FIFA << IQ




end  # module WorldLite
