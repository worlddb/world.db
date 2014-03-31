# encoding: utf-8

module WorldDb

  class Stats

#
# fix: move to ConfDb for (re)use - do not use - use Props.dump or similar!!!!!

    def props
      puts "deprecated API - WorldDb::Stats.props  -- use Props.dump or similar"
      
      puts "Props:"
      Prop.order( 'created_at asc' ).all.each do |prop|
        puts "  #{prop.key} / #{prop.value} || #{prop.created_at}"
      end
    end
  end # class Stats


end # module WorldDb
