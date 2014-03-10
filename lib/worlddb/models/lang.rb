# encoding: utf-8

module WorldDb
  module Model

class Lang < ActiveRecord::Base
    
  has_many :usages  # join table for countries_langs
    
  has_many :countries, :through => :usages

  validates :key, format: { with: /^[a-z]{2}$/, message: 'expected two lowercase letters a-z' }

end  # class Lang

  end # module Model
end # module WorldDb


