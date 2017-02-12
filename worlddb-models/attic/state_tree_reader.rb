
##  was: rec = State.where( "name like '#{node.value}%'" ).first 

Part.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first

## was: rec = County.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first

## was: rec = Muni.where( "name like '#{node.value}%' AND state_id = #{state.id}" ).first

