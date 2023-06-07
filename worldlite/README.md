# worldlite - lightweight public domain country data (all data included as good ol' ruby code - no database, no dependencies, no copyright)

* home  :: [github.com/worlddb/world.lite](https://github.com/worlddb/world.lite)
* bugs  :: [github.com/worlddb/world.lite/issues](https://github.com/worlddb/world.lite/issues)
* gem   :: [rubygems.org/gems/worldlite](https://rubygems.org/gems/worldlite)
* rdoc  :: [rubydoc.info/gems/worldlite](http://rubydoc.info/gems/worldlite)
* forum :: [groups.google.com/group/openmundi](https://groups.google.com/group/openmundi)


## Usage

All data included as good ol' ruby code. Example:

```ruby

module WorldLite

  AT = Country.new do |c|

    c.name   = 'Austria'
    c.key    = 'at'
    c.alpah2 = 'AT'   # iso two-letter country code (ISO 3166-1 alpha-2)
    c.alpha3 = 'AUT'  # iso three-letter country code (ISO 3166-1 alpha-3)
    c.fifa   = 'AUT'  # football country code (fifa = Fédération Int'le de Football Association)
    c.ioc    = 'AUT'  # olympics country code (ioc = International Olympic Committee)
    c.net    = 'at'   # internet top level domain
    c.motor  = 'A'    # motor vehicle license plate code
    c.num3   = '040'  # iso numeric three-digits code as string (ISO 3166-1 numeric)
    c.num    = 40     # iso numeric code as number

    c.continent_name =  'Europe'

    c.un     = true     # United Nations member?  -- 193 member countries
    c.eu     = true     # European Union member?  -- 27 member countries
    c.euro   = true     # Euro Zone member?       -- 17 member countries

    c.wikipedia = 'Austria'   # e.g. see en.wikipedia.org/wiki/Austria
    c.wikidata  = 40          # e.g. see wikidata.org/wiki/Q40
    c.factbook  = 'au'        # e.g. see www.cia.gov/.../the-world-factbook/geos/au.html
    
  end

  WORLD      << AT
  WORLD_UN   << AT
  WORLD_ISO  << AT
  WORLD_FIFA << AT

  EUROPE       << AT
  EUROPE_EU    << AT
  EUROPE_EURO  << AT

end  # module WorldLite
```

(Source: [`worldlite/europe/at-austria.rb`](https://github.com/worlddb/world.lite.ruby/blob/master/lib/worldlite/europe/at_austria.rb))


Use like:

```ruby
require 'worldlite'
include WorldLite

WORLD.size       # => 245
WORLD_UN.size    # => 193
WORLD_G20.size   # => 20
WORLD_COMMONWEALTH.size  # => 54
WORLD_FIFA.size  # => 243
WORLD_WTO.size   # => 157
WORLD_OECD.size  # => 34

EUROPE.size      # => 51
EUROPE_UEFA.size # => 54
EUROPE_EU.size   # => 27
EUROPE_EURO.size # => 17

AT.class.name     # => 'WorldLite::Country'
AT.name           # => 'Austria'
AT.continent_name # => 'Europe'
AT.alpha3         # => 'AUT'
AT.slug           # => 'austria'
AT.un?            # => true
AT.fifa?          # => true
AT.g20?           # => false
AT.eu?            # => true
AT.euro?          # => true

AT.wikpedia       # => 'Austria'
AT.wikidata       # => 40
AT.wikpedia_url   # => 'http://en.wikipedia.org/wiki/Austria'
AT.wikidata_url   # => 'http://www.wikidata.org/wiki/Q40'
AT.factbook       # => 'au'
AT.factbook_url   # => 'http://www.cia.gov/.../the-world-factbook/geos/au.html'
```

## worldlite Summary - 1 Supra / 196 Countries / 48 Territories

#### Europe - 1 Supra / 49 Countries / 10 Territories

1:
`eu` European Union (?)


49:
`al` Albania (ALB)
`ad` Andorra (AND)
`am` Armenia (ARM)
`at` Austria (AUT)
`az` Azerbaijan (AZE)
`by` Belarus (BLR)
`be` Belgium (BEL)
`ba` Bosnia and Herzegovina (BIH)
`bg` Bulgaria (BGR)
`hr` Croatia (HRV)
`cy` Cyprus (CYP)
`cz` Czech Republic (CZE)
`dk` Denmark (DNK)
`ee` Estonia (EST)
`fi` Finland (FIN)
`fr` France (FRA)
`ge` Georgia (GEO)
`de` Germany (DEU)
`gb` Great Britain (GBR)
`gr` Greece (GRC)
`hu` Hungary (HUN)
`is` Iceland (ISL)
`ie` Irland (IRL)
`it` Italy (ITA)
`lv` Latvija (LVA)
`li` Liechtenstein (LIE)
`lt` Lithuania (LTU)
`lu` Luxembourg (LUX)
`mk` Macedonia (MKD)
`mt` Malta (MLT)
`md` Moldova (MDA)
`mc` Monaco (MCO)
`me` Montenegro (MNE)
`nl` Netherlands (NLD)
`no` Norway (NOR)
`pl` Poland (POL)
`pt` Portugal (PRT)
`ro` Romania (ROU)
`ru` Russia (RUS)
`sm` San Marino (SMR)
`rs` Serbia (SRB)
`sk` Slovakia (SVK)
`si` Slovenia (SVN)
`es` Spain (ESP)
`se` Sweden (SWE)
`ch` Switzerland (CHE)
`tr` Turkey (TUR)
`ua` Ukraine (UKR)
`va` Vatican City (VAT)


10:
`en` England (?)
`fo` Faroe Islands (FRO)
`gi` Gibraltar (GIB)
`gg` Guernsey (GGY)
`im` Isle of Man (IMN)
`je` Jersey (JEY)
`nd` Northern Ireland (?)
`sc` Scotland (?)
`wa` Wales (?)
`ax` Åland Islands (ALA)



#### South America - 12 Countries / 4 Territories



12:
`ar` Argentina (ARG)
`bo` Bolivia (BOL)
`br` Brazil (BRA)
`cl` Chile (CHL)
`co` Colombia (COL)
`ec` Ecuador (ECU)
`gy` Guyana (GUY)
`py` Paraguay (PRY)
`pe` Peru (PER)
`sr` Suriname (SUR)
`uy` Uruguay (URY)
`ve` Venezuela (VEN)


4:
`fk` Falkland Islands (FLK)
`gf` French Guiana (GUF)
`sh` Saint Helena (SHN)
`gs` South Georgia and South Sandwich (SGS)



#### North America - 3 Countries / 2 Territories



3:
`ca` Canada (CAN)
`mx` México (MEX)
`us` United States (USA)


2:
`gl` Greenland (GRL)
`pm` Saint Pierre and Miquelon (SPM)



#### Central America - 7 Countries / 0 Territories



7:
`bz` Belize (BLZ)
`cr` Costa Rica (CRI)
`sv` El Salvador (SLV)
`gt` Guatemala (GTM)
`hn` Honduras (HND)
`ni` Nicaragua (NIC)
`pa` Panamá (PAN)





#### Caribbean - 13 Countries / 14 Territories



13:
`ag` Antigua and Barbuda (ATG)
`bs` Bahamas (BHS)
`bb` Barbados (BRB)
`cu` Cuba (CUB)
`dm` Dominica (DMA)
`do` Dominican Republic (DOM)
`gd` Grenada (GRD)
`ht` Haiti (HTI)
`jm` Jamaica (JAM)
`kn` Saint Kitts and Nevis (KNA)
`lc` Saint Lucia (LCA)
`vc` Saint Vincent and the Grenadines (VCT)
`tt` Trinidad and Tobago (TTO)


14:
`ai` Anguilla (AIA)
`aw` Aruba (ABW)
`bm` Bermuda (BMU)
`vg` British Virgin Islands (VGB)
`ky` Cayman Islands (CYM)
`cw` Curaçao (CUW)
`gp` Guadeloupe (GPE)
`mq` Martinique (MTQ)
`ms` Montserrat (MSR)
`pr` Puerto Rico (PUR)
`bl` Saint Barthélemy (BLM)
`mf` Saint Martin (French) (MAF)
`tc` Turks and Caicos Islands (TCA)
`vi` United States Virgin Islands (VIR)



#### Africa - 54 Countries / 2 Territories



54:
`dz` Algeria (DZA)
`ao` Angola (AGO)
`bj` Benin (BEN)
`bw` Botswana (BWA)
`bf` Burkina Faso (BFA)
`bi` Burundi (BDI)
`cm` Cameroon (CMR)
`cv` Cape Verde (CPV)
`cf` Central African Republic (CAF)
`td` Chad (TCD)
`km` Comoros (COM)
`cg` Congo (COG)
`cd` Congo DR (COD)
`ci` Côte d'Ivoire (CIV)
`dj` Djibouti (DJI)
`eg` Egypt (EGY)
`gq` Equatorial Guinea (GNQ)
`er` Eritrea (ERI)
`et` Ethiopia (ETH)
`ga` Gabon (GAB)
`gm` Gambia (GMB)
`gh` Ghana (GHA)
`gn` Guinea (GIN)
`gw` Guinea-Bissau (GNB)
`ke` Kenya (KEN)
`ls` Lesotho (LSO)
`lr` Liberia (LBR)
`ly` Libya (LBY)
`mg` Madagascar (MDG)
`mw` Malawi (MWI)
`ml` Mali (MLI)
`mr` Mauritania (MRT)
`mu` Mauritius (MUS)
`ma` Morocco (MAR)
`mz` Mozambique (MOZ)
`na` Namibia (NAM)
`ne` Niger (NER)
`ng` Nigeria (NGA)
`rw` Rwanda (RWA)
`sn` Senegal (SEN)
`yc` Seychelles (SYC)
`sl` Sierra Leone (SLE)
`so` Somalia (SOM)
`za` South Africa (ZAF)
`ss` South Sudan (SSD)
`sd` Sudan (SDN)
`sz` Swaziland (SWZ)
`st` São Tomé and Príncipe (STP)
`tz` Tanzania (TZA)
`tg` Togo (TGO)
`tn` Tunisia (TUN)
`ug` Uganda (UGA)
`zm` Zambia (ZMB)
`zw` Zimbabwe (ZWE)


2:
`yt` Mayotte (MYT)
`re` Réunion (REU)



#### Middle East - 14 Countries / 0 Territories



14:
`bh` Bahrain (BHR)
`ir` Iran (IRN)
`iq` Iraq (IRQ)
`il` Israel (ISR)
`jo` Jordan (JOR)
`kw` Kuwait (KWT)
`lb` Lebanon (LBN)
`om` Oman (OMN)
`ps` Palestine (PSE)
`qa` Qatar (QAT)
`sa` Saudi Arabia (SAU)
`sy` Syria (SYR)
`ae` United Arab Emirates (ARE)
`ye` Yemen (YEM)





#### Asia - 30 Countries / 5 Territories



30:
`af` Afghanistan (AFG)
`bd` Bangladesh (BGD)
`bt` Bhutan (BTN)
`bn` Brunei (BRN)
`kh` Cambodia (KHM)
`cn` China (CHN)
`in` India (IND)
`id` Indonesia (IDN)
`jp` Japan (JPN)
`kz` Kazakhstan (KAZ)
`kg` Kyrgyzstan (KGZ)
`la` Laos (LAO)
`my` Malaysia (MYS)
`mv` Maldives (MDV)
`mn` Mongolia (MNG)
`mm` Myanmar (MMR)
`np` Nepal (NPL)
`kp` North Korea (PRK)
`pk` Pakistan (PAK)
`ph` Philippines (PHL)
`sg` Singapore (SGB)
`kr` South Korea (KOR)
`lk` Sri Lanka (LKA)
`tw` Taiwan (TWN)
`tj` Tajikistan (TJK)
`th` Thailand (THA)
`tl` Timor-Leste (TLS)
`tm` Turkmenistan (TKM)
`uz` Uzbekistan (UZB)
`vn` Vietnam (VNM)


5:
`io` British Indian Ocean Territory (IOT)
`cx` Christmas Island (CXR)
`cc` Cocos (Keeling) Islands (CCK)
`hk` Hong Kong (HKG)
`mo` Macau (MAC)



#### Pacific - 14 Countries / 11 Territories



14:
`au` Australia (AUS)
`fj` Fiji (FJI)
`ki` Kiribati (KIR)
`mh` Marshall Islands (MHL)
`fm` Micronesia (FSM)
`nr` Nauru (NRU)
`nz` New Zealand (NZL)
`pw` Palau (PLW)
`pg` Papua New Guinea (PNG)
`ws` Samoa (WSM)
`sb` Solomon Islands (SLB)
`to` Tonga (TON)
`tv` Tuvalu (TUV)
`vu` Vanuatu (VUT)


11:
`as` American Samoa (ASM)
`ck` Cook Islands (COK)
`gu` Guam (GUM)
`nc` New Caledonia (NCL)
`nu` Niue (NIU)
`nf` Norfolk Island (NFK)
`mp` Northern Mariana Islands (MNP)
`pn` Pitcairn Islands (PCN)
`pf` Tahiti (TAH)
`tk` Tokelau (TKL)
`wf` Wallis and Futuna (WLF)



## Bonus: World Factbook

```ruby
require 'factbook'

# fetch and parse data from online World Factbook
page = Factbook::Page.new( AT.factbook )   

page['geo']['location']['text']
# => Central Europe, north of Italy and Slovenia

page['geo']['land_boundaries']['border_countries']
# => Czech Republic 362 km, Germany 784 km, Hungary 366 km, Italy 430 km, ...

page['geo']['elevation_extremes']['lowest_point']
# => Neusiedler See 115 m

page['comm']['telephones_mobile_cellular']['text']
# => 13.023 million (2011)

page['comm']['internet_hosts']['text']
# => 3.512 million (2012)

pp page.data
```

```json
{
  "intro": {
    "background": {
      "text": "Once the center of power for the large Austro-Hungarian Empire,
               Austria was reduced to a small republic after its defeat in World War ..."
    }
  },
  "geo": {
    "location": {
      "text": "Central Europe, north of Italy and Slovenia"
    },
    "geographic_coordinates": {
      "text": "47 20 N, 13 20 E"
    },
    "map_references": {
      "text": "Europe"
    },
    "area": {
      "total": "83,871 sq km",
      "land": "82,445 sq km",
      "water": "1,426 sq km"
    },
    "area_comparative": {
      "text": "slightly smaller than Maine"
    },
    "land_boundaries": {
      "total": "2,562 km",
      "border_countries": "Czech Republic 362 km, Germany 784 km, Hungary 366 km, Italy 430 km, Liechtenstein 35 km, Slovakia 91 km, Slovenia 330 km, Switzerland 164 km"
    },
    "coastline": {
      "text": "0 km (landlocked)"
    },
    "maritime_claims": {
      "text": "none (landlocked)"
    },
    "climate": {
      "text": "temperate; continental, cloudy; cold winters with frequent rain and some snow in lowlands and snow in mountains; moderate summers with occasional showers"
    },
    "terrain": {
      "text": "in the west and south mostly mountains (Alps); along the eastern and northern margins mostly flat or gently sloping"
    },
    "elevation_extremes": {
      "lowest_point": "Neusiedler See 115 m",
      "highest_point": "Grossglockner 3,798 m"
    },
    "natural_resources": {
      "text": "oil, coal, lignite, timber, iron ore, copper, zinc, antimony, magnesite, tungsten, graphite, salt, hydropower"
    },
    ...
```


## Alternatives Libraries and Gems

Ruby

- [countries gem](https://github.com/hexorx/countries)
  by Josh Robinson (aka hexorx);
  iso country codes n more

- [iso_country_codes gem](https://github.com/alexrabarts/iso_country_codes)
  by Alex Rabarts;
  iso country codes n more

- [carmen gem](https://github.com/jim/carmen)
  by Jim Benton (aka jim);
  iso country codes n more

- [i18n_data](https://github.com/grosser/i18n_data)
  by Michael Grosser (aka grosser);
  iso country codes; country/language names in 85 languages

- [iso-639 gem](https://github.com/alphabetum/iso-639)
  by William Melody (aka alphabetum);
  iso language codes 

- [world gem](https://github.com/gferraz/world)
  by Gilson Ferraz César (aka gferraz);
  work-in-progress

- Search the Ruby Toolbox w/
  [`country`](https://www.ruby-toolbox.com/search?q=country),
  [`world`](https://www.ruby-toolbox.com/search?q=world),
  [`iso+code`](https://www.ruby-toolbox.com/search?q=iso+code)

- Search RubyGems w/
  [`country`](https://rubygems.org/search?query=country),
  [`world`](https://rubygems.org/search?query=world),
  [`iso+code`](https://rubygems.org/search?query=iso+code)

Others

TBD


## License

The `worldlite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [Open Mundi (world.db) Database Forum/Mailing List](http://groups.google.com/group/openmundi).
Thanks!

