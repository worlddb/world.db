# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Israel'
  c.key    = 'il'
  c.alpha3 = 'ISR'
  c.fifa   = 'ISR'
  c.net    = 'il'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Israel / Middle East
  #    tags: middle east, un, fifa, uefa, western asia, fertile crescent
  IL = c

  WORLD      << IL
  WORLD_UN   << IL
  WORLD_ISO  << IL
  WORLD_FIFA << IL




end  # module WorldLite
