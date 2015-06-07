# encoding: UTF-8

module WorldDb

class StateTreeReader < ReaderBaseWithMoreAttribs

  def read
    ## for now requires country_id !!
    country = Country.find( @more_attribs[ :country_id ] )
    puts "[StateTreeReader] country key: #{country.key}, name: #{country.name}"

    reader = TreeReader.from_string( @text )

    stack = []    # note: last_level  => stack.size; starts w/ 0

    reader.each_line do |nodes|
      names = nodes.map { |item| "(#{item.level}) #{item.value}" }
      node = nodes.last

      puts "    #{names.join( ' › ' )}:"
      puts "      key: >#{node.key}<, level: >#{node.level}<, value: >#{node.value}<"

      if node.level == 1
        rec = State.where( "name like '#{node.value}%'" ).first 
      elsif node.level == 2
        state = stack[0]
        rec = Part.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first
      elsif node.level == 3
        state = stack[0]
        rec = County.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first
      elsif node.level == 4
        state = stack[0]
        rec = Muni.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first
      elsif node.level == 5
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
        if node.level == 4
          ## add muni
          key  = TextUtils.title_to_key( node.value )
          name = node.value
          state  = stack[0]
          county = stack[2]
          puts "*** adding muni record:"
          rec = Muni.create!( key:       key,
                              name:      name,
                              state_id:  state.id,
                              county_id: county.id )
        elsif node.level == 5
          ## add city
          key  = TextUtils.title_to_key( node.value )
          name = node.value
          state  = stack[0]
          county = stack[2]
          muni   = stack[3]
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
