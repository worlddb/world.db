# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'American Samoa'
  c.key    = 'as'
  c.alpha3 = 'ASM'
  c.fifa   = nil
  c.net    = 'as'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  American Samoa / Pacific
  #    tags: pacific, territory
  AS = c

  WORLD      << AS
  WORLD_ISO  << AS




end  # module WorldLite
