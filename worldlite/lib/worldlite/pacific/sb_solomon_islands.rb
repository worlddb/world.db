# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Solomon Islands'
  c.key    = 'sb'
  c.alpha3 = 'SLB'
  c.fifa   = 'SOL'
  c.net    = 'sb'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Solomon Islands / Pacific
  #    tags: un, commonwealth, fifa, ofc, pacific, melanesia
  SB = c

  WORLD      << SB
  WORLD_UN   << SB
  WORLD_ISO  << SB
  WORLD_FIFA << SB
  WORLD_COMMONWEALTH  << SB




end  # module WorldLite
