# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Latvija'
  c.key    = 'lv'
  c.alpha3 = 'LVA'
  c.fifa   = 'LVA'
  c.net    = 'lv'



  c.continent_name =  'Europe'

  c.un     = true
  c.eu     = true
  c.euro   = false

  #  Latvija [Latvia] / Europe
  #    tags: europe, northern europe, baltic, un, eu, fifa, uefa, schengen
  LV = c

  WORLD      << LV
  WORLD_UN   << LV
  WORLD_ISO  << LV
  WORLD_FIFA << LV

  EUROPE       << LV
  EUROPE_EU    << LV



end  # module WorldLite
