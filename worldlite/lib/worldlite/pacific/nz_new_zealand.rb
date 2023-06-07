# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'New Zealand'
  c.key    = 'nz'
  c.alpha3 = 'NZL'
  c.fifa   = 'NZL'
  c.net    = 'nz'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  New Zealand / Pacific
  #    tags: un, commonwealth, fifa, ofc, pacific, polynesia
  NZ = c

  WORLD      << NZ
  WORLD_UN   << NZ
  WORLD_ISO  << NZ
  WORLD_FIFA << NZ
  WORLD_COMMONWEALTH  << NZ




end  # module WorldLite
