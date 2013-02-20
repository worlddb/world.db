# encoding: utf-8

module WorldDB

  class Deleter
    
    ## make models available in worlddb module by default with namespace
    #  e.g. lets you use City instead of Models::City 
    include WorldDB::Models

    def run
      # for now delete all tables
      
      Tagging.delete_all
      Tag.delete_all
      City.delete_all
      Region.delete_all
      Country.delete_all
      Usage.delete_all
      Lang.delete_all
      Prop.delete_all
    end
    
  end # class Deleter

end # module WorldDB