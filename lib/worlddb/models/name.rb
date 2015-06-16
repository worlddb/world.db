# encoding: utf-8


module WorldDb
  module Model

class Name < ActiveRecord::Base

  belongs_to :place,   class_name: 'Place',    foreign_key: 'place_id'


  def place_object  # returns "typed" place object e.g. state, part, county, muni, city, etc.
    ## todo/fix: use switch/when here ??
    if place_kind == 'STAT'
      place.state
    elsif place_kind == 'PART'
      place.part
    else
      puts "*** error [Name#place_object] - unknown place_kind #{place_kind}"
      ## throw exception - unknown type
      nil
    end
  end

  #########
  # finders
  #
  # -- search scoped by country

  def self.find_states( name, country_id )  # note: requires country_id (for search scope)
    recs = Name.joins(
                       :place => :state
                     ).where(
                       :name                => name,
                       :place_kind          => 'STAT',
                       :'states.country_id' => country_id )
    recs
  end

  def self.find_cities( name, country_id ) # note: requires country_id (for search scope)  -- add version w/ state_id scope - why?? why not??
    recs = Name.joins(
                      :place => :city
                     ).where(
                       :name       => name,
                       :place_kind => 'CITY',
                       :'cities.country_id' => country_id )
    recs
  end

  ## -- search scoped by state

  def self.find_parts( name, state_id )  # note requires state_id (for search scope)
    recs = Name.joins(
                       :place => :part
                     ).where(
                       :name                => name,
                       :place_kind          => 'PART',
                       :'parts.state_id' => state_id )
    recs
  end

  def self.find_counties( name, state_id )  # note requires state_id (for search scope)
    recs = Name.joins(
                       :place => :county
                     ).where(
                       :name                => name,
                       :place_kind          => 'COUN',
                       :'counties.state_id' => state_id )
    recs
  end

  def self.find_munis( name, state_id )    # note requires state_id (for search scope)
    recs = Name.joins(
                       :place => :muni
                     ).where(
                        :name             => name,
                        :place_kind       => 'MUNI',
                        :'munis.state_id' => state_id )
    recs
  end



  ########
  # create

  def self.parse( *args )
    ## remove (extract) attribs hash (if last arg is a hash n present)
    more_attribs = args.last.is_a?(Hash) ? args.pop : {}  ## extract_options!
    chunks       = args

    names = NameParser.new.parse( chunks )
    recs = []

    names.each do |name|
      attribs = more_attribs.merge( name: name )  ## overwrite (default) attribs (lang, etc.) plus add name
      puts "[Name.parse] adding Name record:"
      puts "  #{attribs.inspect}"
      rec = Name.create!( attribs )
      recs << rec
    end

    recs # note: returns an array of name records
  end   # method parse

end  # class Name


  end # module Model
end # module WorldDb
