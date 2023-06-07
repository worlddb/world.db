# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'United States Virgin Islands'
  c.key    = 'vi'
  c.alpha3 = 'VIR'
  c.fifa   = nil
  c.net    = 'vi'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  United States Virgin Islands / Caribbean
  #    tags: caribbean, territory
  VI = c

  WORLD      << VI
  WORLD_ISO  << VI




end  # module WorldLite
