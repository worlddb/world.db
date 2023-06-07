# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Papua New Guinea'
  c.key    = 'pg'
  c.alpha3 = 'PNG'
  c.fifa   = 'PNG'
  c.net    = 'pg'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Papua New Guinea / Pacific
  #    tags: un, commonwealth, fifa, ofc, pacific, melanesia
  PG = c

  WORLD      << PG
  WORLD_UN   << PG
  WORLD_ISO  << PG
  WORLD_FIFA << PG
  WORLD_COMMONWEALTH  << PG




end  # module WorldLite
