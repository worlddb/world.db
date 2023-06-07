# encoding: utf-8

module WorldLite


WORLD      = []   ## ary holds all countries; same as Country.all
WORLD_UN   = []   ## ary holds 193 un (united nations) countries
WORLD_ISO  = []   ## ary holds 2?? iso countries
WORLD_FIFA = []   ## ary hold  2?? fifa countries
WORLD_G8   = []
WORLD_G20  = []
WORLD_COMMONWEALTH = []

EUROPE          = []   ## ary holds un countries (from europe)
EUROPE_EU       = []   ## ary holds european union countries (from europe)
EUROPE_EURO     = []   ## ary holds european euro countries (from europe)
## EUROPE_SCHENGEN = []
## EUROPE_UEFA     = []   ## ary holds 54 uefa countries  -- note: includes isreal n kazachstan (from asia)


class Country

  attr_accessor  :name,   # country name e.g. Austria
                 :key,    # key (iso alpha2 if available - otherwise alpha3)
             ##   :num,    # iso numeric code e.g. 41 (as number/int) note: use num3 for number as string w/ leading 0 e.g. 041
             ##   :num3,   # iso numeric code as string (e.g. '041')
             ##  :alpha2, # iso alpha2 code e.g. AT
                 :alpha3, # iso alpha3 code e.g. AUT
                 :fifa,   # fifa (football) code
             ##   :ioc,    # ioc (olympics) code
                 :net,    # internet top level domain (tld) e.g. at
                 :continent_name,    # continent.name  -
                 :kind,   # CTRY|DEPY|SUPR  (country|dependency|supranational)  - add other?
                 :un,     # un (united nations) flag member (true|false)
                 :eu,     # european union flag member (true|false)
                 :euro   # euro (currency) flag member (true|false)
               ##  :schengen,  # flag
               ##  :commonwealth # flag


   def initialize
     yield( self ) if block_given?    # allow setup with code block
   end


   def un?()   @un   end   # boolean convenience methods
   def eu?()   @eu   end
   def euro?() @euro end
   
   def iso?
      # note: for now assumes if no iso code it's not an iso listed country
      @alpha3.nil? ? false : true
   end

   def fifa?
     # note: for now assumes if no fifa code it's not a fifa member country
      @fifa.nil? ? false : true
   end

   def slug
     slugify(name)
   end

   def to_path( opts={} )
     ## e.g. europe/at-austria
     "#{slugify(continent_name)}/#{key}-#{slugify(name)}"
   end


   def wikpedia_url
     "http://en.wikipedia.org/wiki/#{wikpedia}"
   end

   def wikidata_url
     "http://www.wikidata.org/wiki/Q#{wikidata}"
   end

   def factbook_url
     "http://www.cia.gov/library/publications/the-world-factbook/geos/#{factbook}.html"
   end


   def inspect
     ## note: for now use a shorter pretty print (pp) format
     "<#Country name=|#{name}|, key=|#{key}|, to_path=|#{to_path}|>"
   end

  def initialize
    @kind = 'CTRY'   # default to 'sovereign' country - why? why not?
  end


  def self.all
    ## return all countries as an ary e.g. use Country.all
    WORLD
  end

private
   def slugify( txt )
     ## e.g. Austria -> austria
     txt = txt.downcase
     txt = txt.gsub( /[']/, '' )   ## remove some special chars -- todo/fix: add more special chars plus asciify
     txt = txt.gsub( ' ', '-' )
   end

end  # class Country


end  # module WorldLite
