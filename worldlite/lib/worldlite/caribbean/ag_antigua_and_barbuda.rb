# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Antigua and Barbuda'
  c.key    = 'ag'
  c.alpha3 = 'ATG'
  c.fifa   = 'ATG'
  c.net    = 'ag'



  c.continent_name =  'Caribbean'

  c.un     = true
  c.eu     = false
  c.euro   = false

  #  Antigua and Barbuda / Caribbean
  #    tags: caribbean, un, commonwealth, fifa, concacaf, microstate, concacaf cfu
  AG = c

  WORLD      << AG
  WORLD_UN   << AG
  WORLD_ISO  << AG
  WORLD_FIFA << AG
  WORLD_COMMONWEALTH  << AG




end  # module WorldLite
