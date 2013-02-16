module WorldDB

class Opts

  def merge_commander_options!( options = {} )
    @db_path   = options[:dbpath]  if options[:dbpath].present?
    @db_name   = options[:dbname]  if options[:dbname].present?

    @data_path = options[:include] if options[:include].present?
    
    @country   = options[:country]   if options[:country].present?
    
    @countries = options[:countries] if options[:countries].present?
    @regions   = options[:regions]   if options[:regions].present?
    @cities    = options[:cities]    if options[:cities].present?
  end


  def db_path
    @db_path || '.'
  end

  def db_name
    @db_name || 'world.db'
  end



  def country=(value)
    @country = value
  end
  
  def country
    @country   # NB: option has no default; return nil  ## || '.'
  end


  def countries=(boolean)
    @countries = boolean
  end

  def countries?
    return false if @countries.nil?   # default countries flag is false
    @countries == true
  end

  def regions=(boolean)
    @regions = boolean
  end

  def regions?
    return false if @regions.nil?   # default regions flag is false
    @regions == true
  end

  def cities=(boolean)
    @cities = boolean
  end

  def cities?
    return false if @cities.nil?   # default cities flag is false
    @cities == true
  end
  

  def data_path=(value)
    @data_path = value
  end

  def data_path
    @data_path || '.'
  end


end # class Opts

end # module WorldDB
