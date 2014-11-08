# encoding: UTF-8

module WorldDb

class CityReader

  include LogUtils::Logging

## make models available by default with namespace
#  e.g. lets you use Usage instead of Model::Usage
  include Models

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper


  def self.from_zip( zip_file, entry_path, more_attribs={} )
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

    self.from_string( text, more_attribs )
  end


  def self.from_file( path, more_attribs={} )
    ## note: assume/enfore utf-8 encoding (with or without BOM - byte order mark)
    ## - see textutils/utils.rb
    text = File.read_utf8( path )
    self.from_string( text, more_attribs )
  end

  def self.from_string( text, more_attribs={} )
    CityReader.new( text, more_attribs )
  end


  def skip_tags?()   @skip_tags == true;  end
  def strict?()      @strict == true;     end

  def initialize( text, more_attribs={} )
    ## todo/fix: how to add opts={} ???

    @text         = text
    @more_attribs = more_attribs
  end


  def read( name, more_attribs={} )
    reader = ValuesReader.from_string( @text, @more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      City.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class CityReader
end # module WorldDb

