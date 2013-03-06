# encoding: utf-8

module WorldDb::Models

  class Tag < ActiveRecord::Base
    
    has_many :taggings
    
    has_many :cities,    :through => :taggings, :source => :taggable, :source_type => 'WorldDb::Models::City',    :class_name => 'City'
    has_many :countries, :through => :taggings, :source => :taggable, :source_type => 'WorldDb::Models::Country', :class_name => 'Country'
    has_many :regions,   :through => :taggings, :source => :taggable, :source_type => 'WorldDb::Models::Region',  :class_name => 'Region'

    ## nb: only allow spaces and underscore inbetween; do not allow digit as first char
    validates :key,  :format => { :with => /^[a-z]$|^[a-z][a-z0-9_ ]*[a-z0-9]$/, :message => 'expected one or more lowercase letters a-z or 0-9 digits or space or underscore' }

    scope :by_key,   order( 'key desc' )
    scope :by_title, order( 'title desc' )
    scope :top,      where( 'grade=1' )
    
    before_save :on_before_save

    def on_before_save
      # replace space with underscore e.g. north america becomes north_america and so on
      self.slug = key.gsub( ' ', '_' )
      
      ## if title is empty auto fill w/ key
      self.title = key   if title.blank?
    end
      
  end  # class Tag
  
end # module WorldDb::Models
