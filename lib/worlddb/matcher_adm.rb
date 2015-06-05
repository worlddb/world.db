# encoding: UTF-8

####
## matchers for adm2,adm3,etc
##   e.g. parts (regierungsbezirke)
##        counties (kreise,bezirke)

module WorldDb

module Matcher

  def match_adm2_parts_for_country( name, &blk )
    match_xxx_for_country_n_adm1( name, 'parts', &blk )
  end

  def match_adm2_counties_for_country( name, &blk )
    ## note: counties might also be an adm3 match
    match_xxx_for_country_n_adm1( name, 'counties', &blk )
  end

  def match_adm3_counties_for_country( name, &blk )
    match_xxx_for_country_n_adm1_n_adm2( name, 'counties', &blk )
  end


private
  # note: returns name as capture (no code required)
  WORLD_ADMIN_MODERN_PATTERN    = "[0-9]+--([^\\/]+)"

  ###
  ## todo/check: adm1 => state
  ##   why use adm1 and not state ??  duplicate of match___country_n_state ??
  def match_xxx_for_country_n_adm1( name, xxx ) # xxx e.g. parts|counties|etc.

    # auto-add required country n states (from folder structure)
    #
    #  e.g.  de-deutschland!/3--by-bayern/parts  (regierungsbezirke)
    #        europe/de-deutschland!/3--by-bayern/parts
    #
    #    at-austria!/1--n-niederoesterreich/counties  (bezirke)

    xxx_pattern           = "#{xxx}"

    if name =~ /(?:^|\/)#{WORLD_COUNTRY_CLASSIC_PATTERN}\/#{WORLD_STATE_MODERN_PATTERN}\/#{xxx_pattern}/  ||
       name =~ /(?:^|\/)#{WORLD_COUNTRY_CLASSIC_PATTERN}\/#{WORLD_STATE_CLASSIC_PATTERN}\/#{xxx_pattern}/

      country_key = $1.dup
      state_key  = $2.dup
      yield( country_key, state_key )
      true # bingo - match found
    else
      false # no match found
    end
  end


  def match_xxx_for_country_n_adm1_n_adm2( name, xxx ) # xxx e.g. parts|counties|etc.

    # auto-add required country n states (from folder structure)
    #
    #  e.g.  de-deutschland!/3--by-bayern/4--oberfranken/counties  (landkreise)
    #        europe/de-deutschland!/3--by-bayern/4--oberfranken/counties

    xxx_pattern           = "#{xxx}"

    if name =~ /(?:^|\/)#{WORLD_COUNTRY_CLASSIC_PATTERN}\/#{WORLD_STATE_MODERN_PATTERN}\/#{WORLD_ADMIN_MODERN_PATTERN}\/#{xxx_pattern}/  ||
       name =~ /(?:^|\/)#{WORLD_COUNTRY_CLASSIC_PATTERN}\/#{WORLD_STATE_CLASSIC_PATTERN}\/#{WORLD_ADMIN_MODERN_PATTERN}\/#{xxx_pattern}/

      country_key = $1.dup
      state_key  = $2.dup
      adm2        = $3.dup   # lowercase name e.g. oberfranken, oberbayern, etc.
      yield( country_key, state_key, adm2 )
      true # bingo - match found
    else
      false # no match found
    end
  end

end # module Matcher

end # module WorldDb

