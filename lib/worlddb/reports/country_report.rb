# encoding: UTF-8

module WorldDb

class CountryReport

  include Models

  def initialize( key )  # pass in country model - why, why not ??
    @key = key
  end


  def report
    buf = ''

    c = Country.find_by!( key: @key)

    buf << "Country Report for #{c.name} (#{c.key}), "
    buf << "#{c.states.count} states"
    buf << "\n\n"  # print newline

    ## loop over states
    parts_count    = 0
    counties_count = 0
    munis_count    = 0
    cities_count   = 0
    c.states.each do |state|
      buf << "%-36s  |" % ["#{state.name} (#{state.key})"]
      buf << "  %3d parts" % [state.parts.count]
      buf << "  %3d counties" % [state.counties.count]
      buf << "  %3d munis" % [state.munis.count]
      buf << "  %3d cities" % [state.cities.count]
      buf << "\n"  # print newline

      parts_count    += state.parts.count
      counties_count += state.counties.count
      munis_count    += state.munis.count
      cities_count    += state.cities.count

      state.parts.each do |part|
        buf << "  %-34s  |" % ["#{part.name} (#{part.key})"]
        buf << "  %3d counties" % [part.counties.count]
        ## buf << "  %3d munis" % [state.munis.count] -- add munis possilbe??
        buf << "\n"  # print newline
      end # each part
    end # each state

    buf << "\n"  # print newline
    buf << "Total:  "
    buf << "  #{parts_count} parts, "
    buf << "  #{counties_count} counties, "
    buf << "  #{munis_count} munis, "
    buf << "  #{cities_count} cities"
    buf << "\n"  # print newline

    puts buf
  end

end # class CountryReport

end # module WorldDb

