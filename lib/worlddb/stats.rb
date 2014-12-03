# encoding: utf-8

module WorldDb

  class Stats
    include Models

    def tables
      puts "Stats:"
      puts " #{'%5d' % Continent.count} continents"
      puts " #{'%5d' % Country.count} countries (#{Country.where(s: true).count} supras, #{Country.where(d:true).count} deps), #{Country.where(m:true).count} miscs)"
      puts " #{'%5d' % Region.count} regions"
      puts " #{'%5d' % City.where(m: true).where(c: false).count} metros"
      puts " #{'%5d' % City.where(c: true).count} cities (#{City.where(c: true).where(m: true).count} metros)"
      puts " #{'%5d' % City.where(d: true).count} districts"
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

