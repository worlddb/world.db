# encoding: utf-8


## NOTE:
##   add helpers to textutils(!!) valuehelper
##   do NOT create worlddb module

module TextUtils
  module ValueHelper

  ## todo/check: add to pair of matchers??
  # e.g. match_country and match_country!
  #  - match_country will use find_by_key and match_country will use find_by_key! - why? why not?

  def match_country( value )
    if value =~ /^country:/       # country:
      country_key = value[8..-1]  # cut off country: prefix
      country = WorldDb::Model::Country.find_by_key!( country_key )
      yield( country )
      true # bingo - match found
    else
      false # no match found
    end
  end

  def match_supra( value )
    if value =~ /^supra:/         # supra:
      country_key = value[6..-1]  # cut off supra: prefix
      country = WorldDb::Model::Country.find_by_key!( country_key )
      yield( country )
      true # bingo - match found
    else
      false # no match found
    end
  end

  def match_supra_flag( value )  # supranational (country)
    if value =~ /^supra$/   # supra(national)
      yield( true )
      true # bingo - match found
    else
      false # no match found
    end
  end


  def is_state?( value )   # note: was is_region? (use new name only)
    # assume state code e.g. TX or N
    #
    # fix: allow three letter states too e.g. BRU (brussels)
    match_result =  value =~ /^[A-Z]{1,2}$/
    # match found if 0,1,2,3 etc or no match if nil
    # note: return bool e.g. false|true  (not 0,1,2,3 etc. and nil)
    match_result != nil
  end

  ## fix/todo: use match_state_for_country! w/ !!! why? why not?
  def match_state_for_country( value, country_id )  ## NB: required country_id 
    if value =~ /^state:/   ## state:
      state_key = value[6..-1]  ## cut off state: prefix
      state = WorldDb::Model::State.find_by_key_and_country_id!( state_key, country_id )
      yield( state )
      true  # bingo - match found
    elsif is_state?( value )  ## assume state code e.g. TX or N
      state = WorldDb::Model::State.find_by_key_and_country_id!( value.downcase, country_id )
      yield( state )
      true  # bingo - match found
    else
      false # no match found
    end
  end


  def match_city( value )  # NB: might be nil (city not found)
    if value =~ /^city:/   ## city:
      city_key = value[5..-1]  ## cut off city: prefix
      city = WorldDb::Model::City.find_by_key( city_key )
      yield( city )  # NB: might be nil (city not found)
      true # bingo - match found
    else
      false # no match found
    end
  end

  def match_metro( value )
    if value =~ /^metro:/   ## metro:
      metro_key = value[6..-1]  ## cut off metro: prefix
      metro = WorldDb::Model::Metro.find_by_key!( metro_key )
      yield( metro )
      true # bingo - match found
    else
      false # no match found
    end
  end

  def match_metro_flag( value )
    if value =~ /^metro$/   # metro(politan area)
      yield( true )
      true # bingo - match found
    else
      false # no match found
    end
  end

  def match_metro_pop( value )
    if value =~ /^m:/   # m:
      num = value[2..-1].gsub(/[ _]/, '').to_i   # cut off m: prefix; allow space and _ in number
      yield( num )
      true # bingo - match found
    else
      false # no match found
    end
  end

  end # module ValueHelper
end # module TextUtils

