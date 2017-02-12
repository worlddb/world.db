
create_table :cities do |t|

  ## t.float   :lat   # optional for now  --  FIX: remove?? moved to places
  ## t.float   :lng   # optional for now  --  FIX: remove?? moved to places

end

create_table :states do |t|

  t.references :state      ## parent state (optional for now - may be null for top level e.g. state/province)

  ## flags (use single int named flags - why? why not?  
  ### fix: use a generic kind string type flag!!!!!!
  ## t.boolean :s,  null: false, default: false   # state flag (use adm1? or a1)
  ## t.boolean :p,  null: false, default: false   # governmental district falg (use adm2? or a2)  - check is Oberfranken/Oberbayern admin2 in Bayern (DE) ?? - note: might be optional (than adm3 becomes adm2)
  ## t.boolean :c,  null: false, default: false   # county (or bezirk etc.) (use adm3? or a3?)

end

## create_table :city_rels do |t|   ## city relationships (w/ states/admins) -- part of state/zone
##   t.references :city,   null: false
##   t.references :state  ## optional ?? either state/admin or zone ?? use polymorphic assoc or use node w/ kind for place?
##   t.references :zone    ## tourist zone e.g. fraenkische schweiz, wachau, steigerwald, etc. - use own join table???
## end


