# encoding: UTF-8

module WorldDb

class StateTreeReader < ReaderBaseWithMoreAttribs

  def read
    ## for now requires country_id !!
    country = Country.find( @more_attribs[ :country_id ] )
    puts "[StateTreeReader] country key: #{country.key}, name: #{country.name}"

    reader = TreeReader.from_string( @text )

    stack = []    # note: last_level  => stack.size; starts w/ 0

    if country.key == 'de'
      ## use state (1) > part (2) > county (3) > muni (4) > city (5)
      state_level  = 1   # Land
      part_level   = 2   # Regierungsbezirk
      county_level = 3   # Landkreis, Kreisfreie Stadt
      muni_level   = 4   # Gemeinde
      city_level   = 5   # Stadt, Ort, etc.
    else
      ## use state (1) > county (2) > muni (3) > city (4)
      state_level  = 1
      part_level   = -1    ## note: not in use (-1)
      county_level = 2
      muni_level   = 3
      city_level   = 4
    end

    reader.each_line do |nodes|
      names = nodes.map { |item| "(#{item.level}) #{item.value}" }
      node = nodes.last

      puts "    #{names.join( ' › ' )}:"
      puts "      key: >#{node.key}<, level: >#{node.level}<, value: >#{node.value}<"

      if node.level == state_level  # 1
        recs = Name.find_states( node.value, country.id )
      elsif node.level == part_level # 2 
        state = stack[0]
        recs = Name.find_parts( node.value, state.id )
      elsif node.level == county_level  # 2 or 3
        state = stack[0]
        recs = Name.find_counties( node.value, state.id )
      elsif node.level == muni_level   # 3 or 4
        state = stack[0]
        recs = Name.find_munis( node.value, state.id )
      elsif node.level == city_level  # 4 or 5
        ## note: city requires country scope for lookup
        ## todo/fix: how to deal with cities with the same name
        ##   in the same country (and same state and same county etc.) ??? - add some examples here
        recs = Name.find_cities( node.value, country.id )
      else
        puts "*** (fatal) error: unknown level for tree node: #{node.inspect}"
        fail "[StateTreeReader] unknown level for tree node: #{node.inspect}"
      end


      if recs.size > 0
        if recs.size == 1
          puts "ok - record match found: #{recs.inspect}"      
          rec = recs[0].place_object  # e.g. state,part,county,muni,city,etc.
        else
          puts "** ok - #{recs.size} record(s) match found: #{recs.inspect}"
          ## fix/todo: note - uses always first entry for now;
          ##   make lookup/matching more intelligent/usable!!
          rec = recs[0].place_object  # e.g. state,part,county,muni,city,etc.
        end
      else
        ## note: for now only auto-adds munis n cities
        if node.level == muni_level  # 3 or 4
          ## add muni
          key    = TextUtils.title_to_key( node.value )
          name   = node.value
          level  = node.level
          state  = stack[0]
          county = stack[county_level-1]  # note: stack is zero-based (thus, -1)
          puts "*** adding muni record:"
          rec = Muni.create!( key:       key,
                              name:      name,
                              level:     level,
                              state_id:  state.id,
                              county_id: county.id )
        elsif node.level == city_level # 4 or 5
          ## add city
          key    = TextUtils.title_to_key( node.value )
          name   = node.value
          state  = stack[0]
          county = stack[county_level-1]  # note: stack is zero-based (thus, -1)
          muni   = stack[muni_level-1]    # note: stack is zero-based (thus, -1)
          puts "*** adding city record:"
          rec = City.create!( key:        key,
                              name:       name,
                              state_id:   state.id,
                              ## add county_id too ???
                              muni_id:    muni.id,
                              country_id: country.id )
        else
          puts "*** (fatal) error: record not found for tree node: #{node.inspect}"
          fail "[StateTreeReader] record not found for tree node: #{node.inspect}"
        end
      end

      level_diff = node.level - stack.size

      if level_diff > 0
        logger.debug "[StateTreeReader]    up  +#{level_diff}"
        if level_diff > 1
          fail "[StateTreeReader] level diff MUST be +1 is +#{level_diff}"
        end
      elsif level_diff < 0
        logger.debug "[StateTreeReader]    down #{level_diff}"
        level_diff.abs.times { stack.pop }
        stack.pop
      else
        ## same level
        stack.pop
      end
      stack.push( rec )   ## hierarchy of records  (mirrors hierarchy of read-in text)

    end # each_line
  end # method read

end   # class StateTreeReader
end   # module WorldDb

