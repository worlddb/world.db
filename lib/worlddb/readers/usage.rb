# encoding: UTF-8

module WorldDb

class UsageReader

  include LogUtils::Logging

## make models available by default with namespace
#  e.g. lets you use Usage instead of Model::Usage
  include Models

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper


  def self.from_zip()
    ## to be done
  end

  def self.from_file( path, opts={} )
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
