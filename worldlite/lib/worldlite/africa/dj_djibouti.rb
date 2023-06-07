# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Djibouti'
  c.key    = 'dj'
  c.alpha3 = 'DJI'
  c.fifa   = 'DJI'
  c.net    = 'dj'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Djibouti / Africa
  #    tags: africa, eastern africa, un, fifa, caf
  DJ = c

  WORLD      << DJ
  WORLD_UN   << DJ
  WORLD_ISO  << DJ
  WORLD_FIFA << DJ




end  # module WorldLite
