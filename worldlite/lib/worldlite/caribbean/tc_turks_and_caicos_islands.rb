# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Turks and Caicos Islands'
  c.key    = 'tc'
  c.alpha3 = 'TCA'
  c.fifa   = nil
  c.net    = 'tc'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Turks and Caicos Islands / Caribbean
  #    tags: caribbean, territory
  TC = c

  WORLD      << TC
  WORLD_ISO  << TC




end  # module WorldLite
