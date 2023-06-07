# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tahiti'
  c.key    = 'pf'
  c.alpha3 = 'TAH'
  c.fifa   = nil
  c.net    = 'pf'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Tahiti / Pacific
  #    tags: ofc, pacific, polynesia, territory
  PF = c

  WORLD      << PF
  WORLD_ISO  << PF




end  # module WorldLite
