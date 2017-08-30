# encoding: UTF-8

module WorldDb::Model


  ## todo/check:
  ##   add as_row to CityBase for all classes - why? why not??

  class CountrySerializer

    def initialize( country )
      @country = country
    end

    attr_reader :country

    def as_row

      ## todo: add tags too??
      data = { key:      country.key,
               title:    country.title,
               code:     country.code,
               pop:      country.pop,
               area:     country.area,
               synonyms: country.synonyms }
       data
    end
  end # class CountrySerializer

end # module WorldDb::Model
