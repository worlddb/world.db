# encoding: UTF-8

module WorldDb

class CityReader

  include LogUtils::Logging

## make models available by default with namespace
#  e.g. lets you use Usage instead of Model::Usage
  include Models

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper


  def self.from_zip()
    ## to be done
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

