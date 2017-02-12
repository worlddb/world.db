# encoding: UTF-8

module WorldDb

class UsageReader < ReaderBaseWithOpts

  def read
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
