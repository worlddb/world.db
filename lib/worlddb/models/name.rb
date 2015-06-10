# encoding: utf-8


##
# todo: move to textutils!!!

class NameParser

  include LogUtils::Logging

  def parse( chunks )
    ## todo/fix: (re)use nameparser - for now "simple" inline version
    ##  fix!!! - note: for now lang gets ignored
    ##  fix: add hanlde
    ##  Leuven[nl]|Louvain[fr] Löwen[de]
    ##  Antwerpen[nl]|Anvers[fr] [Antwerp]
    ##  Brussel[nl]•Bruxelles[fr]   -> official bi-lingual name
    ##  etc.

    ## values - split into names (name n lang pairs)
    ## note: assumes (default) lang from more_attribs unless otherwise marked e.g. [] assume en etc.

    ## split chunks into values
    values = []
    chunks.each do |chunk|
      next if chunk.nil? || chunk.blank?  ## skip nil or empty/blank chunks

      parts = chunk.split( '|' )   # 1)  split |

      parts.each do |part|
        s = StringScanner.new( part )
        s.skip( /[ \t]+/)   # skip whitespaces

        while s.eos? == false
          if s.check( /\[/ )
            ## scan everything until the end of bracket (e.g.])
            ##  fix!!! - note: for now lang gets ignored
            value = s.scan( /\[[^\]]+\]/)
            value = value[1...-1]   # strip enclosing [] e.g. [Bavaria] => Bavaria
          else
            ## scan everything until the begin of bracket (e.g.[)
            value = s.scan( /[^\[]+/)
            value = value.strip
          end
          values << value

          s.skip( /[ \t]+/)  # skip whitespaces
          logger.debug( "[NameParser] eos?: #{s.eos?}, rest: >#{s.rest}<" )
        end
      end
    end

    logger.debug( "[NameParser] values=#{values.inspect}")

    names = []
    values.each do |value|
      name = value
      ## todo: split by bullet ? (official multilang name) e.g. Brussel • Bruxelles
      ## todo: process variants w/ () e.g. Krems (a. d. Donau) etc. ??
      names << name
    end

    logger.debug( "[NameParser] names=#{names.inspect}")

    names
  end # method parse
end # class NameParser



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
