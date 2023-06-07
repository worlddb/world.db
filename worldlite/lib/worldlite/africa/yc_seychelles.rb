# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Seychelles'
  c.key    = 'yc'
  c.alpha3 = 'SYC'
  c.fifa   = 'SEY'
  c.net    = 'sc'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Seychelles / Africa
  #    tags: africa, eastern africa, indian ocean, un, commonwealth, fifa, caf, microstate
  YC = c

  WORLD      << YC
  WORLD_UN   << YC
  WORLD_ISO  << YC
  WORLD_FIFA << YC
  WORLD_COMMONWEALTH  << YC




end  # module WorldLite
