# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Marshall Islands'
  c.key    = 'mh'
  c.alpha3 = 'MHL'
  c.fifa   = nil
  c.net    = 'mh'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Marshall Islands / Pacific
  #    tags: un, microstate, pacific, micronesia
  MH = c

  WORLD      << MH
  WORLD_UN   << MH
  WORLD_ISO  << MH
  WORLD_FIFA << MH




end  # module WorldLite
