# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Albania'
  c.key    = 'al'
  c.alpha3 = 'ALB'
  c.fifa   = 'ALB'
  c.net    = 'al'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Albania / Europe
  #    tags: europe, southern europe, southeastern europe, balkans, un, fifa, uefa
  AL = c

  WORLD      << AL
  WORLD_UN   << AL
  WORLD_ISO  << AL
  WORLD_FIFA << AL

  EUROPE       << AL



end  # module WorldLite
