
 # builtin path to fixture data
  def self.data_path
    "#{root}/data"
  end
  
  ## todo: remove stats ??? why? why not? better use .tables
  def self.stats
    Stats.new.tables
  end

