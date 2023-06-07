# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Pitcairn Islands'
  c.key    = 'pn'
  c.alpha3 = 'PCN'
  c.fifa   = nil
  c.net    = 'pn'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Pitcairn Islands / Pacific
  #    tags: pacific, territory
  PN = c

  WORLD      << PN
  WORLD_ISO  << PN




end  # module WorldLite
