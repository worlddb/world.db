# encoding: UTF-8

module WorldDb

class LangReader < ReaderBaseWithOpts

  def read
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

  end # method read

end # class LangReader
end # module WorldDb
