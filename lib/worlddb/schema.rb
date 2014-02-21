
module WorldDb

class CreateDb < ActiveRecord::Migration

def up


create_table :places do |t|
  t.string  :name,   null: false
  t.float   :lat   # optional for now (latitude)
  t.float   :lng   # optional for now (longtitude)

  ## todo: add kind/type/feature ??
  ## todo: add parent for hierachy ?? or keep it in country/region/city etc. table ??

  ## timestamp at last
  t.timestamps
end


### alternative names for places
create_table :names do |t|
  t.string     :name,   null: false
  t.references :place,  null: false
  ### todo/fix: add lang_id to reference lang from lang table!!! (for now make it a duplicate; e.g. keep stirng lang for now)
  t.string     :lang,   null: false, default: 'en'   # default to english for now (or use unknown/undeterminded/unspecified???)

  ## todo: add kind/type   ? e.g. postal for postal code ??
  ## or wikipedia for wikipedia?  or use separate table ?? (linkable/links) etc.??

  ## timestamp at last
  t.timestamps
end



create_table :continents do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string     :synonyms  # comma separated list of synonyms

  ## timestamp at last
  t.timestamps
end

add_index :continents, :key, unique: true


create_table :countries do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string     :code,   null: false  # short three letter code (FIFA country code e.g. ITA)
  t.string     :synonyms  # comma separated list of synonyms
  t.integer    :pop,    null: false    # population count
  t.integer    :area,   null: false    #  area in square km (sq. km)
  t.references :continent
  t.references :country    # for supra(nationals) n depend(encies)

  ## flags (use single int named flags - why? why not?  
  t.boolean :s,  null: false, default: false   # supra(national) flag e.g. eu
  t.boolean :c,  null: false, default: false   # country flag (is this needed?)
  t.boolean :d,  null: false, default: false   # dependency flag

  # extras
  t.string  :motor      # optional auto motor (vehicle) licene plate
  t.string  :iso2       # optional iso two letter country code
  t.string  :iso3       # optional iso three letter country code
  t.string  :fifa       # optional fifa country code
  t.string  :net        # optional internet top level domain (tld)
  t.string  :wikipedia  # optional wikipedia page name -- en.wikipedia.org/wiki/<name>

  ## timestamp at last
  t.timestamps
end


add_index :countries, :key,  unique: true
add_index :countries, :code, unique: true


######
# NB: rename to adms/admins ??
#
# used for state/provice/land/regioni/etc.
create_table :regions do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string :code     # short two or three letter code e.g. NY, OAX, etc.
  t.string :abbr     # optional conventional abbrevation (e.g. Stmk., Gto., etc.)
  t.string :iso      # iso code
  t.string :nuts     # nuts code (europe/eu only)
  t.string :synonyms  # comma separated list of synonyms
  t.references :country,  null: false
  t.integer :pop     # optional population count
  t.integer :area    # optional area in square km (sq. km)
  t.timestamps
end

add_index :regions, [:key, :country_id], unique: true


create_table :cities do |t|
  t.string     :name,   null: false
  t.string     :key,    null: false
  t.references :place,  null: false
  t.string :code     # short three letter code (ITAT/airport code e.g. NYC or VIE)
  t.string :synonyms  # comma separated list of synonyms
  t.references :country,  null: false
  t.references :region    # optional for now
  t.references :city  # optional parent (e.g. metro for city, or city for district)
  t.integer :pop     # optional population count (city proper)
  t.integer :popm    # optional population count (metropolitan/aglomeration)
  t.integer :area    # optional area in square km (sq. km)

  ## t.float   :lat   # optional for now  --  FIX: remove?? moved to places
  ## t.float   :lng   # optional for now  --  FIX: remove?? moved to places

  ## flags (use single int named flags - why? why not?    
  t.boolean :m,  null: false, default: false   # metro flag
  t.boolean :c,  null: false, default: false   # city flag (is this needed?)
  t.boolean :d,  null: false, default: false   # district flag

  ### t.boolean :capital, null: false, default: false  # is national captial?

  t.timestamps
end

create_table :tags do |t|
  t.string  :key,  null: false
  t.string  :slug, null: false
  t.string  :name    # todo: make required?  -- note: was title formerly
  t.integer :grade, null: false, default: 1  # grade/tier e.g. 1/2/3 for now
  ## todo: add parent or similar for hierachy (for tag stacks/packs)
  t.timestamps
end

add_index :tags, :key,  unique: true

create_table :taggings do |t|
  t.references :tag,      null: false
  t.references :taggable, polymorphic: true
  t.timestamps   # todo: use only t.datetime :created_at (do we get ar magic? is updated used/needed??)
end

add_index :taggings, :tag_id
add_index :taggings, [:taggable_id, :taggable_type]


create_table :langs do |t|  # langs == languages (e.g. en/English, de/Deutsch, etc.)
  t.string :key,   null: false
  t.string :name, null: false
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


### fix: move to PropDb ? into props gem? why? why not?
create_table :props do |t|
  t.string :key,   null: false
  t.string :value, null: false
  t.timestamps
end

end # method up

def down
  raise ActiveRecord::IrreversibleMigration
end

end # class CreateDb

end # module WorldDb