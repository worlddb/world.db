# encoding: UTF-8

module WorldDb

module Matcher

  #####################################
  ## compat - remove later!!!
  def match_xxx_for_country_n_region( name, xxx )
    match_xxx_for_country_n_state( name, xxx )
  end

  def match_regions_for_country( name, &blk )
    match_states_for_country( name, &blk )
  end

  def match_regions_abbr_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_states_abbr_for_country( name, &blk )
  end

  def match_regions_iso_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_states_iso_for_country( name, &blk )
  end

  def match_regions_nuts_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_states_nuts_for_country( name, &blk )
  end

end # module Matcher

end # module WorldDb

