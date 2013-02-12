# encoding: utf-8


def find_world_db_path_from_gemfile_gitref!
  puts "[debug] find_world_db_path..."
  puts "load path:"
  pp $LOAD_PATH
  
  candidates = []
  $LOAD_PATH.each do |path|
    
    # nb: avoid matching /world.db.ruby/ (e.g. gem "worlddb", "0.10.0", :path => "../world.db.ruby")
    
    if path =~ /world\.db-[a-z0-9]+/
      candidates << path.dup
    end
  end
  
  puts "found candidates:"
  pp candidates
  
  cand = candidates[0]
  
  puts "cand before: #{cand}"
  
  ## nb: *? is non-greedy many operator
  
  regex = /(\/world\.db-.*?)(\/.*)/
  cand = cand.sub( regex ) do |_|
    puts "cutting off >>#{$2}<<"
    $1
  end
  
  puts "cand after: #{cand}"
  
  ## todo:exit with error if not found!!!
  
  cand
end



module WorldDB

  module Fixtures   # use shortcut/alias Fx?

  def self.all  # all builtin fixtures; helper for covenience
     tag_fixtures  + 
     country_fixtures +
     lang_fixtures +
     africa_fixtures  +
     america_fixtures +
     europe_fixtures  +
     asia_fixtures    +
     oceania_fixtures
  end

  def self.tag_fixtures
    ['tags.1', 'tags.3']
  end
  
  def self.country_fixtures
    ['africa/countries',
     'america/countries',
     'asia/countries',
     'europe/countries',
     'oceania/countries']
  end

  def self.lang_fixtures
    ['langs',
     'africa/3_more/lang',
     'america/3_more/lang',
     'asia/3_more/lang',
     'europe/3_more/lang',
     'oceania/3_more/lang'
    ]
  end

  def self.africa_fixtures
    ['1_codes/fifa',
     '1_codes/internet',
     '1_codes/iso3'].map { |path| "africa/#{path}" }
  end

  def self.america_fixtures
  ['1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   '1_codes/motor',
   'br/regions',
   'ca/regions',
   'ca/cities',
   'mx/regions',
   'mx/cities',
   'us/regions',
   'us/cities',
   've/regions',
   've/cities'].map { |path| "america/#{path}" }
  end

  def self.asia_fixtures
  ['1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   'jp/cities'].map { |path| "asia/#{path}" }
  end
  
  def self.europe_fixtures
  ['1_codes/fifa',
   '1_codes/internet',
   '1_codes/iso3',
   '1_codes/motor',
   'at/regions',
   'at/cities',
   'be/regions',
   'be/cities',
   'bg/cities',
   'by/cities',
   'ch/cities',
   'cy/cities',
   'cz/regions',
   'cz/cities',
   'de/regions',
   'de/cities',
   'dk/cities',
   'ee/cities',
   'en/regions',
   'en/cities',
   'es/regions',
   'es/cities',
   'fi/cities',
   'fr/regions',
   'fr/cities',
   'gr/cities',
   'hr/cities',
   'hu/cities',
   'ie/cities',
   'it/cities',
   'lt/cities',
   'lv/cities',
   'nl/cities',
   'no/cities',
   'pl/cities',
   'pt/cities',
   'ro/cities',
   'rs/cities',
   'ru/cities',
   'sc/cities',
   'se/cities',
   'tr/cities',
   'ua/cities',
   'wa/cities'].map { |path| "europe/#{path}" }
  end

  def self.oceania_fixtures
   ['1_codes/fifa',
    '1_codes/internet',
    '1_codes/iso3',
    'au/cities'].map { |path| "oceania/#{path}" }
  end

  end # module Fixtures

end # module WorldDB