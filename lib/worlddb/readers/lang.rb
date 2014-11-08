# encoding: UTF-8

module WorldDb

class LangReader

  include LogUtils::Logging

## make models available by default with namespace
#  e.g. lets you use Usage instead of Model::Usage
  include Models

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper


  ## todo: add opts={} etc.
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
    LangReader.new( text, opts )
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
      ##  move to Lang.read() for (re)use

        logger.debug "adding lang >>#{key}<< >>#{value}<<..."
      
        lang_key   = key.strip
        lang_title = value.strip
      
        lang_attribs = {}
        
        ## check if it exists
        lang = Lang.find_by_key( lang_key )
        if lang.present?
          logger.debug "update lang #{lang.id}-#{lang.key}:"
        else
          logger.debug "create lang:"
          lang = Lang.new
          lang_attribs[ :key ] = lang_key
        end
        
        lang_attribs[ :title ] = lang_title
        
        logger.debug lang_attribs.to_json
     
        lang.update_attributes!( lang_attribs )
    end # each key,value

  end # method load_langs


end # class LangReader
end # module WorldDb
