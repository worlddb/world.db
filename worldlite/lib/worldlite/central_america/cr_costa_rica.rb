# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Costa Rica'
  c.key    = 'cr'
  c.alpha3 = 'CRI'
  c.fifa   = 'CRC'
  c.net    = 'cr'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Costa Rica / Central America
  #    tags: central america, un, fifa, concacaf, concacaf uncaf
  CR = c

  WORLD      << CR
  WORLD_UN   << CR
  WORLD_ISO  << CR
  WORLD_FIFA << CR




end  # module WorldLite
