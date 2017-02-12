
module WorldDb

class CreateDb

def up

ActiveRecord::Schema.define do

create_table :places do |t|
  t.string  :name,   null: false
  t.string  :kind,   null: false  # --  kind/feature (note: type reserved for activerecord sti)
  #####
  # continent:
  #  CONT - continent (use CNTI or CENT why??)
  # country:
  #  SUPR - supra (e.g. European Union)
  #  CNTY - country
  #  TERR - terr
  # state:
  #  STAT  -- was: ADM1 - e.g. state/province/etc.
  #  PART   e.g. regierungsbezirk ADM2
  #  COUN -- was ADM2/ADM3 - e.g. county/bezirk/kreis/etc.
  #  MUNI -  was ADM3/ADM4 - e.g. municipality/gemeinde/etc.
  # city:
  #  MTRO - metro
  #  CITY - city/town/village/hamlet //(de)ort/stadt/markt
  #  DIST - district/
  #
  #  add new table for zones (e.g. informal regions e.g. tourism, wine regions, etc.) ??
  #   why? why not??


  t.float   :lat   # optional for now (latitude)
  t.float   :lng   # optional for now (longitude)

  ## todo: add parent for hierachy ?? or keep it in country/state/city etc. table
  ##    or use extra hierachy join table ??

  ## timestamp at last
  t.timestamps
end


#############
# todo: use many-to-many assoc w/ join table  for name and place ???
#  why? why not?
#    - wien -> city n state n metro ?  collect more samples of names used more than once

### alternative names for places
create_table :names do |t|
  t.string     :name,   null: false
  t.references :place,      null: false
  t.string     :place_kind, null: false  #  add (cached) place_kind for easier search queries (w/o join)

  ### todo/fix: add lang_id to reference lang from lang table!!! (for now make it a duplicate; e.g. keep stirng lang for now)
  t.string     :lang,   null: false, default: 'en'   # default to english for now (or use unknown/undeterminded/unspecified???)

  ## todo: add kind/type   ? e.g. postal for postal code ??
  ## or wikipedia for wikipedia?  or use separate table ?? (linkable/links) etc.??

  ## timestamp at last
  t.timestamps
end



create_table :continents do |t|
  t.string     :name,     null: false
  t.string     :slug,     null: false   # auto-generate default
  t.string     :key,      null: false
  t.references :place,    null: false
  t.string     :alt_names  # comma separated list of alternate names (synonyms)

  ## timestamp at last
  t.timestamps
end

add_index :continents, :key, unique: true


create_table :country_codes do |t|
  t.string     :name, null: false
  t.string     :kind, null: false   # e.g. ALPHA2,NUM,FIFA,IOC,FIPS,NET,etc.
  t.references :country, null: false
end

add_index :country_codes, [:name, :kind], unique: true


create_table :countries do |t|
  t.string     :name,   null: false
  t.string     :slug,   null: false   # auto-generate default
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string     :code,   null: false  # short three letter code (FIFA country code e.g. ITA)
  t.string     :alt_names  # comma separated list of alternate names (synonyms)
  t.string     :hist_names # comma separated list of historic names (no longer in use)
  t.integer    :pop,    null: false    # population count
  t.integer    :area,   null: false    #  area in square km (sq. km)
  t.references :continent
  t.references :country    # for supra(nationals) n depend(encies)

  ## flags (use single int named flags - why? why not?  
  ### fix: use a generic kind string type flag!!!!!!
  t.boolean :s,  null: false, default: false   # supra(national) flag e.g. eu
  t.boolean :c,  null: false, default: false   # country flag (is this needed?)
  t.boolean :d,  null: false, default: false   # dependency flag

  t.boolean :m,  null: false, default: false   # misc(ellaneous) flag
  # misc use for territories w/ shared or disputed claims
  #   e.g. Antartica/Western Sahara/Paracel Islands/Spratly Islands/etc.

  # extras - country codes
  t.string  :motor      # optional  motor (vehicle) licene plate code (bumper sticker)
  t.string  :alpha2       # optional iso two letter country code
  t.string  :alpha3       # optional iso three letter country code
  t.string  :num        #  optional iso numeric country code - NOTE: same numeric code as string!!! e.g. 043 etc.
  t.string  :fifa       # optional fifa country code
  t.string  :ioc
  t.string  :fips
  t.string  :net        # optional internet top level domain (tld)

  t.string  :wikipedia  # optional wikipedia page name -- en.wikipedia.org/wiki/<name>

  ## timestamp at last
  t.timestamps
end


add_index :countries, :key,  unique: true
add_index :countries, :code, unique: true



######
# used for state/provice/land/regioni/etc.
create_table :states do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string :code     # short two or three letter code e.g. NY, OAX, etc.
  t.string :abbr     # optional conventional abbrevation (e.g. Stmk., Gto., etc.)
  t.string :iso      # iso code
  t.string :nuts     # nuts code (europe/eu only)
  t.string :alt_names  # comma separated list of alternate names (synonyms)

  t.references :country,  null: false
  t.integer    :level,    null: false, default: 1  # default assumes 1 e.g. state/province/etc.
  ### change to l (instead of level)!!!! - shorter, why, why not???

  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)
  t.timestamps
end

### fix: add kind to unique ???
add_index :states, [:key, :country_id], unique: true


####
#  todo: use a view (of states/admins) instead - why? why not??
#  parts used for regierungsbezirke
create_table :parts do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string :code     # short two or three letter code e.g. NY, OAX, etc.
  t.string :abbr     # optional conventional abbrevation (e.g. Stmk., Gto., etc.)
  t.string :iso      # iso code  -- check in use/possible - ???
  t.string :nuts     # nuts code (europe/eu only)
  t.string :alt_names  # comma separated list of alternate names (synonyms)

  t.references :state,  null: false
  t.integer    :level,  null: false, default: 2  # default assumes 2
  ### change to l (instead of level)!!!! - shorter, why, why not???

  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)
  t.timestamps
end

####
#  todo: use a view (of states/admins) instead - why? why not??
#    counties used for kreise, bezirke, etc.

create_table :counties do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string :code     # short two or three letter code e.g. NY, OAX, etc.
  t.string :abbr     # optional conventional abbrevation (e.g. Stmk., Gto., etc.)
  t.string :iso      # iso code  -- check in use/possible - ???
  t.string :nuts     # nuts code (europe/eu only)
  t.string :alt_names  # comma separated list of alternate names (synonyms)

  t.references :state,  null: false
  t.references :part    # optional part (e.g. regierungsbezirk, etc.)
  t.integer    :level,  null: false, default: 2  # default assumes 2 - note: is (change to) 3 if parts incl.
  ### change to l (instead of level)!!!! - shorter, why, why not???

  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)
  t.timestamps
end


####
#  todo: use a view (of states/admins) instead - why? why not??
#    counties used for kreise, bezirke, etc.

create_table :munis do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string :code     # short two or three letter code e.g. NY, OAX, etc.
  t.string :abbr     # optional conventional abbrevation (e.g. Stmk., Gto., etc.)
  t.string :iso      # iso code  -- check in use/possible - ???
  t.string :nuts     # nuts code (europe/eu only)
  t.string :alt_names  # comma separated list of alternate names (synonyms)

  t.references :state,  null: false
  t.references :county   # optional county (e.g. bezirk,kreis, etc.)
  t.integer    :level,  null: false, default: 3  # default assumes 3 - note: is (change to) 4 if parts incl.
  ### change to l (instead of level)!!!! - shorter, why, why not???

  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)
  t.timestamps
end



## kind of regions but not hierachical (used for tourist/colloquial zones etc.)
#    uses many-to-many join tables w/ cities n states/admins
#
#  examples:
#    Salzkammergut (part of Salzburg and Oberoesterreich)
#  others
#   Oberfranken -> Fichtelgebierge/Fraenkische Schweiz/etc.
create_table :zones do |t|
  # to be done
end


create_table :cities do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string     :code     # short three letter code (ITAT/airport code e.g. NYC or VIE)
  t.string     :alt_names  # comma separated list of alternate names (synonyms)

  t.references :country,  null: false
  t.references :state    # optional for now (e.g. state, bundesland, etc.)  -- ADM1
  t.references :part     # optional for now (e.g. regierungsbezirk, etc.)   -- x   /ADM2
  t.references :county   # optional for now (e.g. landkreis, bezirk, etc.)  -- ADM2/ADM3
  t.references :muni     # optional for now (e.g. gemeinde, etc.)           -- ADM3/ADM4

  t.references :metro    # optional for now (part of metro e.g. Ruhrgebiet or Vienna Metro(politean) Area etc.)

  t.integer :pop     # optional population count (city proper); see metro for metro pop
  t.integer :area    # optional area in square km (sq. km)

  ### t.boolean :capital, null: false, default: false  # is national captial?

  t.timestamps
end

create_table :metros do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string     :code     # short three letter code (ITAT/airport code e.g. NYC or VIE)
  t.string     :alt_names  # comma separated list of alternate names (synonyms)
  t.references :country,  null: false

  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)

  t.timestamps
end

create_table :districts do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string     :code     # short three letter code (ITAT/airport code e.g. NYC or VIE)
  t.string     :alt_names  # comma separated list of alternate names (synonyms)
  t.references :city,  null: false

  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)

  t.timestamps
end



create_table :langs do |t|  # langs == languages (e.g. en/English, de/Deutsch, etc.)
  t.string :key,   null: false
  t.string :name,  null: false
  t.timestamps
end


create_table :usages do |t|  # join table for countries_langs
  t.references :country,  null: false
  t.references :lang,     null: false
  t.boolean    :official, null: false, default: true  # is_official language in country
  t.boolean    :minor,    null: false, default: false # spoken by minority 
  t.float      :percent     # usage in percent e.g. 90.0, 0.55, etc.
  t.timestamps
end

end # block Schema.define

end # method up


end # class CreateDb

end # module WorldDb
