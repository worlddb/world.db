# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Isle of Man'
  c.key    = 'im'
  c.alpha3 = 'IMN'
  c.fifa   = nil
  c.net    = 'im'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Isle of Man / Europe
  #    tags: europe, northern europe, western europe, territory
  IM = c

  WORLD      << IM
  WORLD_ISO  << IM

  EUROPE       << IM



end  # module WorldLite
