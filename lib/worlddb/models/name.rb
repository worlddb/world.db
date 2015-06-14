# encoding: utf-8


module WorldDb
  module Model

class Name < ActiveRecord::Base


  def self.parse( *args )
    ## remove (extract) attribs hash (if last arg is a hash n present)
    more_attribs = args.last.is_a?(Hash) ? args.pop : {}  ## extract_options!
    chunks       = args

    names = NameParser.new.parse( chunks )
    recs = []

    names.each do |name|
      attribs = more_attribs.merge( name: name )  ## overwrite (default) attribs (lang, etc.) plus add name
      puts "[Name.parse] adding Name record:"
      puts "  #{attribs.inspect}"
      rec = Name.create!( attribs )
      recs << rec
    end

    recs # note: returns an array of name records
  end   # method parse

end  # class Name


  end # module Model
end # module WorldDb
