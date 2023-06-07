# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Guam'
  c.key    = 'gu'
  c.alpha3 = 'GUM'
  c.fifa   = nil
  c.net    = 'gu'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Guam / Pacific
  #    tags: pacific, territory
  GU = c

  WORLD      << GU
  WORLD_ISO  << GU




end  # module WorldLite
