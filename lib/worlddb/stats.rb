# encoding: utf-8

module WorldDb

  class Stats
    include Models

    def tables
      puts "Stats:"
      puts " #{'%5d' % Continent.count} continents"
      puts " #{'%5d' % Country.count} countries (#{Country.where(s: true).count} supras, #{Country.where(d:true).count} deps), #{Country.where(m:true).count} miscs)"
      puts " #{'%5d' % State.count} states (ADM1)"
      puts " #{'%5d' % Part.count} parts (x/ADM2)"
      puts " #{'%5d' % County.count} counties (ADM2/ADM3)"
      puts " #{'%5d' % Muni.count} munis (ADM3/ADM4)"
      puts " #{'%5d' % Metro.count} metros"
      puts " #{'%5d' % City.count} cities"
      puts " #{'%5d' % District.count} districts"
      puts " #{'%5d' % Place.count} places"
      puts " #{'%5d' % Name.count} names"

      puts " #{'%5d' % Lang.count} langs"
      puts " #{'%5d' % Usage.count} usages"

      puts " #{'%5d' % CountryCode.count} (country) codes"

#      puts " #{'%5d' % Tag.count} tags"
#      puts " #{'%5d' % Tagging.count} taggings"
    end

  end # class Stats

end # module WorldDb

