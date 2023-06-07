# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Faroe Islands'
  c.key    = 'fo'
  c.alpha3 = 'FRO'
  c.fifa   = 'FRO'
  c.net    = 'fo'



  c.continent_name =  'Europe'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Faroe Islands / Europe
  #    tags: europe, northern europe, nordic, fifa, uefa, territory
  FO = c

  WORLD      << FO
  WORLD_ISO  << FO
  WORLD_FIFA << FO

  EUROPE       << FO



end  # module WorldLite
