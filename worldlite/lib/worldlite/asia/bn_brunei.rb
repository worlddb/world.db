# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Brunei'
  c.key    = 'bn'
  c.alpha3 = 'BRN'
  c.fifa   = 'BRU'
  c.net    = 'bn'



  c.continent_name =  'Asia'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Brunei / Asia
  #    tags: asia, un, commonwealth, fifa, afc, southeast asia
  BN = c

  WORLD      << BN
  WORLD_UN   << BN
  WORLD_ISO  << BN
  WORLD_FIFA << BN
  WORLD_COMMONWEALTH  << BN




end  # module WorldLite
