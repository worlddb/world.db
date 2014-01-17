# encoding: UTF-8

module WorldDb

module Matcher

  def match_xxx_for_country( name, xxx )  # xxx e.g. cities|regions|beers|breweries
    #      auto-add required country code (from folder structure)
    if name =~ /(?:^|\/)([a-z]{2,3})-[^\/]+\/#{xxx}/         ||    # (1)
       name =~ /(?:^|\/)[0-9]+--([a-z]{2,3})-[^\/]+\/#{xxx}/ ||    # (2)
       name =~ /(?:^|\/)([a-z]{2,3})\/#{xxx}/                      # (3)

      country_key = $1.dup
      yield( country_key )
      true # bingo - match found
      
      ######
      # (1)  new style: e.g. /at-austria/beers or ^at-austria!/beers
      #
      # (2)  new-new style e.g. /1--at-austria--central/beers
      #
      # (3)  classic style: e.g. /at/beers (europe/at/beers)
    else
      false # no match found
    end
  end

  def match_xxx_for_country_n_region( name, xxx ) # xxx e.g. beers|breweries
    # auto-add required country n region code (from folder structure)
    if name =~ /(?:^|\/)([a-z]{2,3})-[^\/]+\/([a-z]{1,3})-[^\/]+\/#{xxx}/  ||                # (1)
       name =~ /(?:^|\/)[0-9]+--([a-z]{2,3})-[^\/]+\/[0-9]+--([a-z]{1,3})-[^\/]+\/#{xxx}/ || # (2)
       name =~ /(?:^|\/)([a-z]{2,3})-[^\/]+\/[0-9]+--([a-z]{1,3})-[^\/]+\/#{xxx}/         || # (3)
       name =~ /(?:^|\/)[0-9]+--([a-z]{2,3})-[^\/]+\/([a-z]{1,3})-[^\/]+\/#{xxx}/            # (4)
      
      #######
      # nb: country must start name (^) or coming after / e.g. europe/at-austria/...
      # (1)
      # new style: e.g.  /at-austria/w-wien/beers or
      #                  ^at-austria!/w-wien/beers
      # (2)
      # new new style e.g.  /1--at-austria--central/1--w-wien--eastern/beers
      #
      # (3)
      #  new new mixed style e.g.  /at-austria/1--w-wien--eastern/beers
      #      "classic" country plus new new region
      #
      # (4)
      #  new new mixed style e.g.  /1--at-austria--central/w-wien/beers
      #      new new country plus "classic" region

      country_key = $1.dup
      region_key  = $2.dup
      yield( country_key, region_key )
      true # bingo - match found
    else
      false # no match found
    end
  end


  def match_cities_for_country( name, &blk )
    ## todo: check if there's a better (more ruby way) to pass along code block ??
    ## e.g. try
    ##   match_xxx_for_country( name, 'cities') { |country_key| yield(country_key) }

    match_xxx_for_country( name, 'cities', &blk )
  end

  def match_regions_for_country( name, &blk )
    ## todo: check if there's a better (more ruby way) to pass along code block ??
    match_xxx_for_country( name, 'regions', &blk )
  end

  def match_regions_abbr_for_country( name, &blk )
    match_xxx_for_country( name, 'regions\.abbr', &blk )  # NB: . gets escaped for regex, that is, \.
  end

  def match_regions_iso_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_xxx_for_country( name, 'regions\.iso', &blk )
  end

  def match_regions_nuts_for_country( name, &blk )  # NB: . gets escaped for regex, that is, \.
    match_xxx_for_country( name, 'regions\.nuts', &blk )
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
