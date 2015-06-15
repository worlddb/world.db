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

      ## use name for lookup - use where() to find - might match more than 1 record!!
      ##   todo/fix: check for multiple or no matches!!!
      ##   todo/fix: check how to add state.id scope (and country.id scope) etc.
      ##   add state.id to name - why? why not?
      ##  move finders to name model for reuse (and testing) - why? why not ??
      if node.level == state_level  # 1
        ##  was: rec = State.where( "name like '#{node.value}%'" ).first 
        names = Name.joins(
                       :place => :state
                     ).find_by(
                        :name                => node.value,
                        :place_kind          => 'STAT',
                        :'states.country_id' => country.id )
        rec = if names.nil?
          nil
        else
          names.place.state   # get first record; fix: use where instead of find_by etc.
        end
      elsif node.level == part_level # 2 
        state = stack[0]
        rec = Part.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first
      elsif node.level == county_level  # 2 or 3
        state = stack[0]
        ## was: rec = County.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first
        names = Name.joins(
                       :place => :county
                     ).find_by(
                       :name                => node.value,
                       :place_kind          => 'COUN',
                       :'counties.state_id' => state.id )
        rec = if names.nil?
          nil
        else
          names.place.county   # get first record
        end
      elsif node.level == muni_level   # 3 or 4
        state = stack[0]
        ## was: rec = Muni.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first
        names = Name.joins(
                       :place => :muni
                     ).find_by(
                        :name             => node.value,
                        :place_kind       => 'MUNI',
                        :'munis.state_id' => state.id )
        rec = if names.nil?
          nil
        else
          names.place.muni   # get first record
        end
      elsif node.level == city_level  # 4 or 5
        ## note: city requires country scope for lookup
        ## todo/fix: how to deal with cities with the same name
        ##   in the same country (and same state and same county etc.) ??? - add some examples here
        rec = City.where( "name like '#{node.value}%' AND country_id = #{country.id}" ).first
      else
        puts "*** (fatal) error: unknown level for tree node: #{node.inspect}"
        ## todo/fix: exit here
      end


      if rec.present?
        puts "ok - record match found: #{rec.inspect}"
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
          ## todo/fix: exit here
        end
      end

      level_diff = node.level - stack.size

      if level_diff > 0
        logger.debug "[StateTreeReader]    up  +#{level_diff}"
        ## FIX!!! todo/check/verify/assert: always must be +1
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

