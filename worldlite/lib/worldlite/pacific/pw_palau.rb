# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Palau'
  c.key    = 'pw'
  c.alpha3 = 'PLW'
  c.fifa   = nil
  c.net    = 'pw'



  c.continent_name =  'Pacific'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Palau / Pacific
  #    tags: un, microstate, pacific, micronesia
  PW = c

  WORLD      << PW
  WORLD_UN   << PW
  WORLD_ISO  << PW
  WORLD_FIFA << PW




end  # module WorldLite
