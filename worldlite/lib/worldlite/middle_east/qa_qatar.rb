# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Qatar'
  c.key    = 'qa'
  c.alpha3 = 'QAT'
  c.fifa   = 'QAT'
  c.net    = 'qa'



  c.continent_name =  'Middle East'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Qatar / Middle East
  #    tags: middle east, un, fifa, afc, western asia, afc waff, arabian peninsula
  QA = c

  WORLD      << QA
  WORLD_UN   << QA
  WORLD_ISO  << QA
  WORLD_FIFA << QA




end  # module WorldLite
