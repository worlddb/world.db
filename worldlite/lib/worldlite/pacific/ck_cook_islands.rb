# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Cook Islands'
  c.key    = 'ck'
  c.alpha3 = 'COK'
  c.fifa   = nil
  c.net    = 'ck'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Cook Islands / Pacific
  #    tags: pacific, territory
  CK = c

  WORLD      << CK
  WORLD_ISO  << CK




end  # module WorldLite
