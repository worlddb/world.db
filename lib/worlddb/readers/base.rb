# encoding: UTF-8

module WorldDb


class BaseReader

  include LogUtils::Logging

## make models available by default with namespace
#  e.g. lets you use Usage instead of Model::Usage
  include Models

## value helpers e.g. is_year?, is_taglist? etc.
  include TextUtils::ValueHelper


  attr_reader :include_path

  def skip_tags?()   @skip_tags == true;  end
  def strict?()      @strict == true;     end


  def initialize( include_path, opts = {} )
    
    @include_path = include_path
    
    ## option: do NOT generate/add any tags for countries/regions/cities
    @skip_tags =  opts[:skip_tags].present? ? true : false
    ## option: for now issue warning on update, that is, if key/record (country,region,city) already exists
    @strict    =  opts[:strict].present? ? true : false
  end


  def read( name, more_attribs={} )
    puts "error: overwrite in concrete reader class!!!"  ### overwrite!!!!
  end


end # class BaseReader
end # module WorldDb
