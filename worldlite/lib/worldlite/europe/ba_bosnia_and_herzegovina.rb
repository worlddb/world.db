# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Bosnia and Herzegovina'
  c.key    = 'ba'
  c.alpha3 = 'BIH'
  c.fifa   = 'BIH'
  c.net    = 'ba'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Bosnia and Herzegovina / Europe
  #    tags: europe, southern europe, southeastern europe, balkans, un, fifa, uefa
  BA = c

  WORLD      << BA
  WORLD_UN   << BA
  WORLD_ISO  << BA
  WORLD_FIFA << BA

  EUROPE       << BA



end  # module WorldLite
