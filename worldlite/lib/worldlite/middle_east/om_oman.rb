# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Oman'
  c.key    = 'om'
  c.alpha3 = 'OMN'
  c.fifa   = 'OMA'
  c.net    = 'om'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Oman / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, arabian peninsula
  OM = c

  WORLD      << OM
  WORLD_UN   << OM
  WORLD_ISO  << OM
  WORLD_FIFA << OM




end  # module WorldLite
