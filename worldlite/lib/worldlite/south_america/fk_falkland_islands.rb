# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Falkland Islands'
  c.key    = 'fk'
  c.alpha3 = 'FLK'
  c.fifa   = nil
  c.net    = 'fk'



  c.continent_name =  'South America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Falkland Islands / South America
  #    tags: south america, territory
  FK = c

  WORLD      << FK
  WORLD_ISO  << FK




end  # module WorldLite
