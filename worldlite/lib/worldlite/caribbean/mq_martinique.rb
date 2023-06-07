# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Martinique'
  c.key    = 'mq'
  c.alpha3 = 'MTQ'
  c.fifa   = nil
  c.net    = 'mq'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Martinique / Caribbean
  #    tags: caribbean, concacaf, concacaf cfu, territory
  MQ = c

  WORLD      << MQ
  WORLD_ISO  << MQ




end  # module WorldLite
