# encoding: UTF-8

module WorldDb

class StateReader < ReaderBaseWithMoreAttribs

  def read
    reader = ValuesReader.from_string( @text, @more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      State.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class StateReader


class PartReader < ReaderBaseWithMoreAttribs

  def read
    reader = ValuesReader.from_string( @text, @more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      Part.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class PartReader


class CountyReader < ReaderBaseWithMoreAttribs

  def read
    reader = ValuesReader.from_string( @text, @more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      County.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class CountyReader


class MuniReader < ReaderBaseWithMoreAttribs

  def read
    reader = ValuesReader.from_string( @text, @more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      Muni.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class MuniReader


end # module WorldDb
