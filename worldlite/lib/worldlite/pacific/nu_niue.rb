# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Niue'
  c.key    = 'nu'
  c.alpha3 = 'NIU'
  c.fifa   = nil
  c.net    = 'nu'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Niue / Pacific
  #    tags: pacific, territory
  NU = c

  WORLD      << NU
  WORLD_ISO  << NU




end  # module WorldLite
