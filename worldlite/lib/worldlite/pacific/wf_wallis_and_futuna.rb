# encoding: utf-8

module WorldLite

  c = Country.new
  c.name   = 'Wallis and Futuna'
  c.key    = 'wf'
  c.alpha3 = 'WLF'
  c.fifa   = nil
  c.net    = 'wf'



  c.continent_name =  'Pacific'

  c.un     = false
  c.eu     = false
  c.euro   = false

  #  Wallis and Futuna / Pacific
  #    tags: pacific, territory
  WF = c

  WORLD      << WF
  WORLD_ISO  << WF




end  # module WorldLite
