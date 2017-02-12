# encoding: UTF-8

module WorldDb

class CityReader < ReaderBaseWithMoreAttribs

  def read
    reader = ValuesReader.from_string( @text, @more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      City.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class CityReader
end # module WorldDb

