# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Samoa'
  c.key    = 'ws'
  c.alpha3 = 'WSM'
  c.fifa   = 'SAM'
  c.net    = 'ws'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Samoa / Pacific
  #    tags: un, commonwealth, fifa, ofc, pacific, polynesia
  WS = c

  WORLD      << WS
  WORLD_UN   << WS
  WORLD_ISO  << WS
  WORLD_FIFA << WS
  WORLD_COMMONWEALTH  << WS




end  # module WorldLite
