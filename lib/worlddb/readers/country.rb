# encoding: UTF-8

module WorldDb

class CountryReader < BaseReader

  def read( name, more_attribs={} )
    reader = ValuesReaderV2.new( name, include_path, more_attribs )

    reader.each_line do |attribs, values|
      opts = { skip_tags: skip_tags? }
      Country.create_or_update_from_attribs( attribs, values, opts )
    end
  end

end # class CountryReader
end # module WorldDb
