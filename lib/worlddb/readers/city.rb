# encoding: UTF-8

module WorldDb

class CityReader < BaseReader

  def read( name, more_attribs={} )
    reader = ValuesReaderV2.new( name, include_path, more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      City.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class CityReader
end # module WorldDb

