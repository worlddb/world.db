# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Anguilla'
  c.key    = 'ai'
  c.alpha3 = 'AIA'
  c.fifa   = nil
  c.net    = 'ai'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Anguilla / Caribbean
  #    tags: caribbean, territory
  AI = c

  WORLD      << AI
  WORLD_ISO  << AI




end  # module WorldLite
