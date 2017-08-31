# encoding: UTF-8

module WorldDb::Model


  ## todo/check:
  ##   add as_row to CityBase for all classes - why? why not??

  class CitySerializer

    def initialize( city )
      @city = city
    end

    attr_reader :city

    def as_row

      ## add virtual column like kind for metro, metro|city, city, district

      ## todo add region.title if present
      ## todo add metro.name if available - why? why not??

      data = { key:      city.key,
               name:     city.name,
               code:     city.code,
               pop:      city.pop,
               area:     city.area,
               synonyms: city.synonyms,
               country:  city.country.name }
      data
    end

  end # class CitySerializer

end # module WorldDb::Model
