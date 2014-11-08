# encoding: UTF-8

module WorldDb

class UsageReader

  include LogUtils::Logging

## make models available by default with namespace
#  e.g. lets you use Usage instead of Model::Usage
  include Models

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper

  ## todo: add opts
  def self.from_zip( zip_file, entry_path )
    ## get text content from zip

    entry = zip_file.find_entry( entry_path )

    ## todo/fix: add force encoding to utf-8 ??
    ##  check!!!
    ##  clean/prepprocess lines
    ##  e.g. CR/LF (/r/n) to LF (e.g. /n)
    text = entry.get_input_stream().read()

    ## NOTE: needs logger ref; only available in instance methods; use global logger for now
    logger = LogUtils::Logger.root
    logger.debug "text.encoding.name (before): #{text.encoding.name}"
#####
# NB: ASCII-8BIT == BINARY == Encoding Unknown; Raw Bytes Here
## NB:
# for now "hardcoded" to utf8 - what else can we do?
# - note: force_encoding will NOT change the chars only change the assumed encoding w/o translation
    text = text.force_encoding( Encoding::UTF_8 )
    logger.debug "text.encoding.name (after): #{text.encoding.name}"     

    ## todo:
    # NB: for convenience: convert fancy unicode dashes/hyphens to plain ascii hyphen-minus
    ## text = TextUtils.convert_unicode_dashes_to_plain_ascii( text, path: path )

    self.from_string( text )
  end

  def self.from_file( path, opts={} )
    ## note: assume/enfore utf-8 encoding (with or without BOM - byte order mark)
    ## - see textutils/utils.rb
    text = File.read_utf8( path )
    self.from_string( text, opts )
  end

  def self.from_string( text, opts={} )
    UsageReader.new( text, opts )
  end


  def skip_tags?()   @skip_tags == true;  end
  def strict?()      @strict == true;     end

  def initialize( text, opts={} )
    @text = text

    ## option: do NOT generate/add any tags for countries/regions/cities
    @skip_tags =  opts[:skip_tags].present? ? true : false
    ## option: for now issue warning on update, that is, if key/record (country,region,city) already exists
    @strict    =  opts[:strict].present? ? true : false
  end

  def read()
    reader = HashReader.from_string( @text )

    reader.each do |key, value|
      
      ### fix:
      ##  move to Usage.read() for (re)use

      logger.debug "   adding langs >>#{value}<<to country >>#{key}<<"
      
      country = Country.find_by_key!( key )
      
      lang_keys = value.split(',')
      lang_keys.each do |lang_key|

        ### remove (optional comment) from key (e.g. carribean (islands))
        lang_key = lang_key.gsub( /\(.+\)/, '' )
        ## remove leading n trailing space
        lang_key = lang_key.strip

        lang = Lang.find_by_key!( lang_key )
        Usage.create!( country_id: country.id, lang_id: lang.id, official: true, minor: false )
      end
    end
  end


end # class UsageReader
end # module WorldDb
