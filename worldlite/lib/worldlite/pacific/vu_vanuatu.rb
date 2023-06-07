# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Vanuatu'
  c.key    = 'vu'
  c.alpha3 = 'VUT'
  c.fifa   = 'VAN'
  c.net    = 'vu'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Vanuatu / Pacific
  #    tags: un, commonwealth, fifa, ofc, pacific, melanesia
  VU = c

  WORLD      << VU
  WORLD_UN   << VU
  WORLD_ISO  << VU
  WORLD_FIFA << VU
  WORLD_COMMONWEALTH  << VU




end  # module WorldLite
