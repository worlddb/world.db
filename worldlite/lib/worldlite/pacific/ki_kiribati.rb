# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Kiribati'
  c.key    = 'ki'
  c.alpha3 = 'KIR'
  c.fifa   = nil
  c.net    = 'ki'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Kiribati / Pacific
  #    tags: un, commonwealth, microstate, pacific, micronesia
  KI = c

  WORLD      << KI
  WORLD_UN   << KI
  WORLD_ISO  << KI
  WORLD_FIFA << KI
  WORLD_COMMONWEALTH  << KI




end  # module WorldLite
