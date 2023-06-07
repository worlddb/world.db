# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Tokelau'
  c.key    = 'tk'
  c.alpha3 = 'TKL'
  c.fifa   = nil
  c.net    = 'tk'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Tokelau / Pacific
  #    tags: pacific, territory
  TK = c

  WORLD      << TK
  WORLD_ISO  << TK




end  # module WorldLite
