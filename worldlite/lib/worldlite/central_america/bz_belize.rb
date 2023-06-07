# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Belize'
  c.key    = 'bz'
  c.alpha3 = 'BLZ'
  c.fifa   = 'BLZ'
  c.net    = 'bz'



  c.continent_name =  'Central America'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Belize / Central America
  #    tags: central america, un, commonwealth, fifa, concacaf, concacaf uncaf
  BZ = c

  WORLD      << BZ
  WORLD_UN   << BZ
  WORLD_ISO  << BZ
  WORLD_FIFA << BZ
  WORLD_COMMONWEALTH  << BZ




end  # module WorldLite
