# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Central African Republic'
  c.key    = 'cf'
  c.alpha3 = 'CAF'
  c.fifa   = 'CTA'
  c.net    = 'cf'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Central African Republic / Africa
  #    tags: africa, central africa, un, fifa, caf
  CF = c

  WORLD      << CF
  WORLD_UN   << CF
  WORLD_ISO  << CF
  WORLD_FIFA << CF




end  # module WorldLite
