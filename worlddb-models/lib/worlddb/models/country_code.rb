# encoding: utf-8

module WorldDb
  module Model

class CountryCode < ActiveRecord::Base

  self.table_name = 'country_codes'

  belongs_to :country, class_name: 'Country', foreign_key: 'country_id'


  scope :by_name,  ->{ order( 'name asc' ) }   # order by name (a-z)


  def self.update!
    ## update (auto-create) country codes from existing countries in db

    ## fix: add/configure logger for ActiveRecord!!!
    logger = LogKernel::Logger.root

    logger.debug( "delete all (old) country codes" )
    CountryCode.delete_all

    Country.order(:id).each do |cty|
      logger.debug( "add country #{cty.key} #{cty.name}" )
      CountryCode.create!( country_id: cty.id, kind: 'NET',  name: cty.net    )  unless cty.net.nil?
      CountryCode.create!( country_id: cty.id, kind: 'NUM',  name: cty.num    )  unless cty.num.nil?
      CountryCode.create!( country_id: cty.id, kind: 'A2',   name: cty.alpha2 )  unless cty.alpha2.nil?
      CountryCode.create!( country_id: cty.id, kind: 'A3',   name: cty.alpha3 )  unless cty.alpha3.nil?
      CountryCode.create!( country_id: cty.id, kind: 'FIFA', name: cty.fifa   )  unless cty.fifa.nil?
      CountryCode.create!( country_id: cty.id, kind: 'IOC',  name: cty.ioc    )  unless cty.ioc.nil?
      CountryCode.create!( country_id: cty.id, kind: 'FIPS', name: cty.fips   )  unless cty.fips.nil?
      CountryCode.create!( country_id: cty.id, kind: 'M',    name: cty.motor  )  unless cty.motor.nil?
    end
  end

end # class CountryCode

  end # module Model
end # module WorldDb
