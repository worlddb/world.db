# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cyprus'
  c.key    = 'cy'
  c.alpha3 = 'CYP'
  c.fifa   = 'CYP'
  c.net    = 'cy'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = true

  #  Cyprus / Europe
  #    tags: asia, europe, southern europe, middle east, un, eu, commonwealth, fifa, uefa, euro, western asia, mediterranean
  CY = c

  WORLD      << CY
  WORLD_UN   << CY
  WORLD_ISO  << CY
  WORLD_FIFA << CY
  WORLD_COMMONWEALTH  << CY

  EUROPE       << CY
  EUROPE_EU    << CY
  EUROPE_EURO  << CY



end  # module WorldLite
