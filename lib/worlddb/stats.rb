# encoding: utf-8

module WorldDb

  class Stats
    include WorldDb::Models

    def tables
      puts "Stats:"
      puts " #{'%5d' % Continent.count} continents"
      puts " #{'%5d' % Country.count} countries (#{Country.where(s: true).count} supras, #{Country.where(d:true).count} deps)"
      puts " #{'%5d' % Region.count} regions"
      puts " #{'%5d' % City.where(m: true).where(c: false).count} metros"
      puts " #{'%5d' % City.where(c: true).count} cities (#{City.where(c: true).where(m: true).count} metros)"
      puts " #{'%5d' % City.where(d: true).count} districts"
#      puts " #{'%5d' % Tag.count} tags"
#      puts " #{'%5d' % Tagging.count} taggings"
      puts " #{'%5d' % Place.count} places"
      puts " #{'%5d' % Name.count} names"
      puts " #{'%5d' % Lang.count} langs"
      puts " #{'%5d' % Usage.count} usages"
    end


#
# fix: move to ConfDb for (re)use !!!!!

    def props
      puts "Props:"
      Prop.order( 'created_at asc' ).all.each do |prop|
        puts "  #{prop.key} / #{prop.value} || #{prop.created_at}"
      end
    end
  end # class Stats


end # module WorldDb