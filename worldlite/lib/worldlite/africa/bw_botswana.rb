# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Botswana'
  c.key    = 'bw'
  c.alpha3 = 'BWA'
  c.fifa   = 'BOT'
  c.net    = 'bw'



  c.continent_name =  'Africa'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Botswana / Africa
  #    tags: africa, southern africa, un, commonwealth, fifa, caf
  BW = c

  WORLD      << BW
  WORLD_UN   << BW
  WORLD_ISO  << BW
  WORLD_FIFA << BW
  WORLD_COMMONWEALTH  << BW




end  # module WorldLite
