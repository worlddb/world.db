
  ### use CountryAttr Reader
  def load_xxx( xxx, name )
    reader = create_hash_reader( name )

    reader.each do |key, value|
      country = Country.find_by_key!( key )
      country.send( "#{xxx}=", value )
      country.save!
    end
  end

