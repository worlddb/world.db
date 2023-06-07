# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Northern Mariana Islands'
  c.key    = 'mp'
  c.alpha3 = 'MNP'
  c.fifa   = nil
  c.net    = 'mp'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Northern Mariana Islands / Pacific
  #    tags: pacific, territory
  MP = c

  WORLD      << MP
  WORLD_ISO  << MP




end  # module WorldLite
