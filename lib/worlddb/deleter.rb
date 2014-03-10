# encoding: utf-8

module WorldDb

  class Deleter
    
    ## make models available in worlddb module by default with namespace
    #  e.g. lets you use City instead of Models::City 
    include WorldDb::Models

    def run
      # for now delete all tables
      
      ## Tagging.delete_all   # - use TagDb.delete!
      ## Tag.delete_all
      City.delete_all
      Region.delete_all
      Country.delete_all
      Continent.delete_all
      Usage.delete_all
      Lang.delete_all
      #  Prop.delete_all    # - use ConfDb.delete!
    end
    
  end # class Deleter

end # module WorldDb