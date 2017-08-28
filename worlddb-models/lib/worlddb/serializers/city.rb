# encoding: UTF-8

module WorldDb::Model


  ## todo/check:
  ##   add as_tab(ular) to CityBase for all classes - why? why not??

  class CitySerializer

    def initialize( city )
      @city = city
    end

    attr_reader :city

    def as_tab  # as_tabular (returns an array of records/hashes)

      ## add virtual column like kind for metro, metro|city, city, district

      ## todo add region.title if present

      data = { key:      city.key,
               title:    city.title,
               code:     city.code,
               pop:      city.pop,
               popm:     city.popm,
               area:     city.area,
               synonyms: city.synonyms,
               country:  city.country.title }
      data
    end

  end # class CitySerializer

end # module WorldDb::Model
