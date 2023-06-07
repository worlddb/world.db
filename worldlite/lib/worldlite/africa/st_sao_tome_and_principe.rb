# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'São Tomé and Príncipe'
  c.key    = 'st'
  c.alpha3 = 'STP'
  c.fifa   = 'STP'
  c.net    = 'st'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  São Tomé and Príncipe / Africa
  #    tags: africa, central africa, atlantic ocean, un, fifa, caf, microstate
  ST = c

  WORLD      << ST
  WORLD_UN   << ST
  WORLD_ISO  << ST
  WORLD_FIFA << ST




end  # module WorldLite
