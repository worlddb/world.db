# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tuvalu'
  c.key    = 'tv'
  c.alpha3 = 'TUV'
  c.fifa   = nil
  c.net    = 'tv'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Tuvalu / Pacific
  #    tags: un, commonwealth, ofc, microstate, pacific, polynesia
  TV = c

  WORLD      << TV
  WORLD_UN   << TV
  WORLD_ISO  << TV
  WORLD_FIFA << TV
  WORLD_COMMONWEALTH  << TV




end  # module WorldLite
