# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Saint Pierre and Miquelon'
  c.key    = 'pm'
  c.alpha3 = 'SPM'
  c.fifa   = nil
  c.net    = 'pm'



  c.continent_name =  'North America'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Saint Pierre and Miquelon / North America
  #    tags: north america, territory
  PM = c

  WORLD      << PM
  WORLD_ISO  << PM




end  # module WorldLite
