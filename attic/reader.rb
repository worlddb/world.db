#!/usr/bin/env ruby

 def load_builtin( name )  ## convenience helper (requires proper named files w/ convention)
    load_with_include_path( name, WorldDB.data_path )
  end

  def load_countries_builtin( name, more_values={} )
    load_countries_with_include_path( name, WorldDB.data_path, more_values )
  end

 def load_regions_builtin( country_key, name )
    load_regions_with_include_path( country_key, name, WorldDB.data_path )
 end
 
  def load_cities_builtin( country_key, name )
    load_cities_with_include_path( country_key, name, WorldDB.data_path )
  end

  def load_langs_builtin( name )
    load_langs_with_include_path( name, WorldDB.data_path )
  end

  def load_tags_builtin( name, include_path, more_values={} )
    load_tags_with_include_path( name, WorldDB.data_path, more_values )
  end

  def load_usages_builtin( name )
    load_usages_with_include_path( name, WorldDB.data_path )
  end

  def load_xxx_builtin( xxx, name )
    load_xxx_with_include_path( xxx, name, WorldDB.data_path )
  end


