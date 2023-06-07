# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tonga'
  c.key    = 'to'
  c.alpha3 = 'TON'
  c.fifa   = 'TGA'
  c.net    = 'to'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Tonga / Pacific
  #    tags: un, commonwealth, fifa, ofc, microstate, pacific, polynesia
  TO = c

  WORLD      << TO
  WORLD_UN   << TO
  WORLD_ISO  << TO
  WORLD_FIFA << TO
  WORLD_COMMONWEALTH  << TO




end  # module WorldLite
