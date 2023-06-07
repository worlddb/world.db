# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Micronesia'
  c.key    = 'fm'
  c.alpha3 = 'FSM'
  c.fifa   = nil
  c.net    = 'fm'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Micronesia / Pacific
  #    tags: un, microstate, pacific, micronesia
  FM = c

  WORLD      << FM
  WORLD_UN   << FM
  WORLD_ISO  << FM
  WORLD_FIFA << FM




end  # module WorldLite
