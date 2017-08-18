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

## rotterdam

```
[info] parsing data (city) in zip 'europe/nl-netherlands/cities' (world.db-master/europe/nl-netherlands/cities.txt)...
[debug] text.encoding.name (before): UTF-8
[debug] text.encoding.name (after): UTF-8
[debug] ReaderBase.from_string calling WorldDb::CityReader.new
[debug] skipping blank line (1)
[debug] skipping comment line
[debug] skipping blank line (2)
[debug] line: |»Rotterdam-Den Haag [Rotterdam-The Hague]« » m:2_113_000« » metro«|
[debug]   values: |»Rotterdam-Den Haag [Rotterdam-The Hague]« »m:2_113_000« »metro«|
[debug] skipping blank line (1)
[debug] skipping blank line (2)
[debug] skipping comment line
[debug] skipping blank line (3)
[debug] [NameTokenizer] eos?: false, rest: >[Rotterdam-The Hague]<
[debug] [NameTokenizer] eos?: true, rest: ><
[debug] [NameTokenizer] names=["Rotterdam-Den Haag", "[Rotterdam-The Hague]"]
[debug]    autogen key »rotterdamdenhaag« from title »Rotterdam-Den Haag«
[debug] (auto-)create Metro:
[debug] {"pop":2113000,"key":"rotterdamdenhaag","name":"Rotterdam-Den Haag","country_id":15}
[debug] [NameParser] eos?: true, rest: ><
[debug] [NameParser] values=["Rotterdam-Den Haag"]
[debug] [NameParser] names=["Rotterdam-Den Haag"]
[Name.parse] adding Name record:
  {:place_id=>619, :place_kind=>"MTRO", :name=>"Rotterdam-Den Haag"}
[debug] update WorldDb::Model::Metro 29-rotterdamdenhaag:
[debug] {"title":"Rotterdam-Den Haag","synonyms":"[Rotterdam-The Hague]","key":"rotterdamdenhaag","country_id":15,"metro
_id":29}

*** error: unknown attribute 'metro_id' for WorldDb::Model::Metro.
gems/activemodel-5.1.3/lib/active_model/attribute_assignment.rb:48:in `_assig
n_attribute'
gems/activemodel-5.1.3/lib/active_model/attribute_assignment.rb:40:in `block
in _assign_attributes'
gems/activemodel-5.1.3/lib/active_model/attribute_assignment.rb:39:in `each'
gems/activemodel-5.1.3/lib/active_model/attribute_assignment.rb:39:in `_assig
n_attributes'
gems/activerecord-5.1.3/lib/active_record/attribute_assignment.rb:26:in `_ass
ign_attributes'
gems/activemodel-5.1.3/lib/active_model/attribute_assignment.rb:33:in `assign
_attributes'
gems/activerecord-5.1.3/lib/active_record/persistence.rb:297:in `block in upd
ate!'
gems/activerecord-5.1.3/lib/active_record/transactions.rb:384:in `block in wi
th_transaction_returning_status'
gems/activerecord-5.1.3/lib/active_record/connection_adapters/abstract/databa
se_statements.rb:235:in `block in transaction'
gems/activerecord-5.1.3/lib/active_record/connection_adapters/abstract/transa
ction.rb:194:in `block in within_new_transaction'
Ruby2.3.0/lib/ruby/2.3.0/monitor.rb:214:in `mon_synchronize'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/activerecord-5.1.3/lib/active_record/connection_adapters/abstract/transa
ction.rb:191:in `within_new_transaction'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/activerecord-5.1.3/lib/active_record/connection_adapters/abstract/databa
se_statements.rb:235:in `transaction'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/activerecord-5.1.3/lib/active_record/transactions.rb:210:in `transaction
'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/activerecord-5.1.3/lib/active_record/transactions.rb:381:in `with_transa
ction_returning_status'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/activerecord-5.1.3/lib/active_record/persistence.rb:296:in `update!'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/models/city_base.rb:206:in `create_or_u
pdate_from_attribs'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/readers/city.rb:12:in `block in read'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/values_reader.rb:100:in `block in e
ach_line'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/values_reader.rb:250:in `block in e
ach_line_with_meta'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/values_reader.rb:134:in `each_line'

Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/values_reader.rb:134:in `each_line_
with_meta'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/values_reader.rb:90:in `each_line'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/readers/city.rb:10:in `read'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/reader.rb:86:in `block in load'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/matcher.rb:103:in `match_xxx_for_countr
y'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/matcher.rb:20:in `match_cities_for_coun
try'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/reader.rb:80:in `load'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/reader.rb:35:in `block in load_setup'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/fixture_reader.rb:121:in `block in
each'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/fixture_reader.rb:120:in `each'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/textutils-1.4.0/lib/textutils/reader/fixture_reader.rb:120:in `each'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/reader.rb:34:in `load_setup'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-models-2.3.4/lib/worlddb/models.rb:111:in `read_setup_from_zip'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/datafile-0.2.5/lib/datafile/workers/zip/world.rb:14:in `read'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/datafile-0.2.5/lib/datafile/workers/zip/worker.rb:26:in `block in read'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/datafile-0.2.5/lib/datafile/workers/zip/worker.rb:25:in `each'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/datafile-0.2.5/lib/datafile/workers/zip/worker.rb:25:in `read'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/datafile-0.2.5/lib/datafile/datafile.rb:128:in `read'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-2.3.0/lib/worlddb/cli/main.rb:151:in `block (2 levels) in <class
:Toolii>'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/gli-2.16.1/lib/gli/command_support.rb:131:in `execute'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/gli-2.16.1/lib/gli/app_support.rb:296:in `block in call_command'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/gli-2.16.1/lib/gli/app_support.rb:309:in `call_command'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/gli-2.16.1/lib/gli/app_support.rb:83:in `run'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-2.3.0/lib/worlddb/cli/main.rb:16:in `run'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-2.3.0/lib/worlddb.rb:21:in `main'
Ruby2.3.0/lib/ruby/gems/2.3.0/gems/worlddb-2.3.0/bin/worlddb:7:in `<top (required)>'
Ruby2.3.0/bin/worlddb:22:in `load'
Ruby2.3.0/bin/worlddb:22:in `<main>'
```
