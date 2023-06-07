# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Martin (French)'
  c.key    = 'mf'
  c.alpha3 = 'MAF'
  c.fifa   = nil
  c.net    = 'mf'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Saint Martin (French) / Caribbean
  #    tags: caribbean, territory
  MF = c

  WORLD      << MF
  WORLD_ISO  << MF




end  # module WorldLite
