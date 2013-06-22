# encoding: UTF-8

module WorldDb

module Matcher

  def match_xxx_for_country( name, xxx, blk )  # xxx e.g. cities|regions|beers|breweries
    if name =~ /(?:^|\/)([a-z]{2})-[^\/]+\/#{xxx}/
      # new style: e.g. /at-austria/beers or ^at-austria!/beers
      # auto-add required country code (from folder structure)
      country_key = $1.dup
      blk.call( country_key )
      true # bingo - match found
    elsif name =~ /\/([a-z]{2})\/#{xxx}/
      # classic style: e.g. /at/beers (europe/at/beers)
      # auto-add required country code (from folder structure)
      country_key = $1.dup
      blk.call( country_key )
      true
    else
      false # no match found
    end
  end

  def match_xxx_for_country_n_region( name, xxx, blk ) # xxx e.g. beers|breweries
    if name =~ /(?:^|\/)([a-z]{2})-[^\/]+\/([a-z]{1,2})-[^\/]+\/#{xxx}/
      # new style: e.g.  /at-austria/w-wien/beers or
      #                  ^at-austria!/w-wien/beers 
      # nb: country must start name (^) or coming after / e.g. europe/at-austria/...
      #
      # auto-add required country n region code (from folder structure)
      country_key = $1.dup
      region_key  = $2.dup
      blk.call( country_key, region_key )
      true # bingo - match found
    else
      false # no match found
    end
  end


  def match_cities_for_country( name, &blk )
    match_xxx_for_country( name, 'cities', blk )
  end

  def match_regions_for_country( name, &blk )
    match_xxx_for_country( name, 'regions', blk )
  end

  def match_regions_abbr_for_country( name, &blk )
    match_xxx_for_country( name, 'regions\.abbr', blk )  # NB: . gets escaped for regex, that is, \.
  end

  def match_regions_iso_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_xxx_for_country( name, 'regions\.iso', blk )
  end

  def match_regions_nuts_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_xxx_for_country( name, 'regions\.nuts', blk )
  end


  def match_countries_for_continent( name )
    if name =~ /^([a-z][a-z\-_]+[a-z])\/countries/     # e.g. africa/countries or america/countries
      ### NB: continent changed to regions (e.g. middle-east, caribbean, north-america, etc.)
      ## auto-add continent (from folder structure) as tag
      ## fix: allow dash/hyphen/minus in tag
      continent = $1.dup
      yield( continent )
      true
    else
      false # no match found
    end
  end

end # module Matcher

end # module WorldDb
