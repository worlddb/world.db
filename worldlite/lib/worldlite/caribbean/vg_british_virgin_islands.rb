# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'British Virgin Islands'
  c.key    = 'vg'
  c.alpha3 = 'VGB'
  c.fifa   = nil
  c.net    = 'vg'



  c.continent_name =  'Caribbean'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  British Virgin Islands / Caribbean
  #    tags: caribbean, territory
  VG = c

  WORLD      << VG
  WORLD_ISO  << VG




end  # module WorldLite
