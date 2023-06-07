# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Montenegro'
  c.key    = 'me'
  c.alpha3 = 'MNE'
  c.fifa   = 'MNE'
  c.net    = 'me'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Montenegro / Europe
  #    tags: europe, southern europe, southeastern europe, balkans, un, fifa, uefa
  ME = c

  WORLD      << ME
  WORLD_UN   << ME
  WORLD_ISO  << ME
  WORLD_FIFA << ME

  EUROPE       << ME



end  # module WorldLite
