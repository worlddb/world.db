# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Norfolk Island'
  c.key    = 'nf'
  c.alpha3 = 'NFK'
  c.fifa   = nil
  c.net    = 'nf'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Norfolk Island / Pacific
  #    tags: pacific, territory
  NF = c

  WORLD      << NF
  WORLD_ISO  << NF




end  # module WorldLite
