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


## nameparser

allow alternatives in translations; see denmark states e.g.

```
## fix:!!!!! nameparser allow alternative in translations e.g.
##
##  Hovedstaden [Greater Copenhagen|Capital Region]
##  Nordjylland [North Denmark|North Jutland]
##  Midtjylland [Central Denmark|Central Jutland]


h,  Hovedstaden [Greater Copenhagen],                Hillerød, 2_561 km², 1_714_486   ## use h - why? why not? in common use?
sj, Sjælland [Zealand],                              Sorø,     7_273 km²,   817_907   ## use sl - why? why not? in common use?
n,  Nordjylland [North Denmark],                     Aalborg,  8_020 km²,   579_996
m,  Midtjylland [Central Denmark],                   Viborg,  13_053 km², 1_266_682
s,  Syddanmark  [South Denmark],                     Vejle,   12_191 km², 1_201_342   ## use s - why? why not? in common use?
```
