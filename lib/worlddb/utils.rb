# encoding: utf-8


class Time
  
  def self.cet( str )   # central european time (cet) + central european summer time (cest)  
    ActiveSupport::TimeZone['Vienna'].parse( str )
  end

  def self.eet( str )  # eastern european time (eet)  + 2 hours
    ActiveSupport::TimeZone['Bucharest'].parse( str )
  end
  
  def self.cst( str )  # central standard time (cst) - 6 hours 
    ActiveSupport::TimeZone['Mexico City'].parse( str )
  end
  
end # class Time


##### fix/todo: move to helper folder - use one file per module/helper

module WorldDb
  module TagHelper

  def find_tags( value )
    # logger.debug "   found tags: >>#{value}<<"

    tag_keys = value.split('|')

    ## unify; replace _w/ space; remove leading n trailing whitespace
    tag_keys = tag_keys.map do |key|
      key = key.gsub( '_', ' ' )
      key = key.strip
      key
    end

    tag_keys # return tag keys as ary
  end

  def find_tags_in_hash!( h )
    # NB: will remove :tags from hash

    if h[:tags].present?
      tag_keys = find_tags( h[:tags] )
      h.delete(:tags)
      tag_keys   # return tag keys as ary
    else
      []  # nothing found; return empty ary
    end
  end

  end # module
end # module WorldDb
