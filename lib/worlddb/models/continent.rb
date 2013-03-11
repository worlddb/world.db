# encoding: utf-8

module WorldDb::Models

  class Continent < ActiveRecord::Base
    
    has_many :countries
    
    validates :key, :format => { :with => /^[a-z]{2,}$/, :message => 'expected two or more lowercase letters a-z' }

  end  # class Continent

end # module WorldDb::Models
