# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'New Caledonia'
  c.key    = 'nc'
  c.alpha3 = 'NCL'
  c.fifa   = nil
  c.net    = 'nc'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  New Caledonia / Pacific
  #    tags: pacific, territory
  NC = c

  WORLD      << NC
  WORLD_ISO  << NC




end  # module WorldLite
