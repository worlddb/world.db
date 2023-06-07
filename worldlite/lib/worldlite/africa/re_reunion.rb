# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Réunion'
  c.key    = 're'
  c.alpha3 = 'REU'
  c.fifa   = nil
  c.net    = 're'



  c.continent_name =  'Africa'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Réunion / Africa
  #    tags: africa, territory
  RE = c

  WORLD      << RE
  WORLD_ISO  << RE




end  # module WorldLite
