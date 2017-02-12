# TODOS


in models/city.rb - fix:

```
    values.each_with_index do |value,index|
      ### fix,fix,fix:  use match_state(s)_for_country - where defined - check!!!
      ##  defined in textutils/helper/value_helper!!!
      ##   move back to worlddb-models!!!!!!
      if match_region_for_country( value, new_attributes[:country_id] ) do |state|
           new_attributes[ :state_id ] = state.id
         end
```
