# encoding: utf-8


class HashReader

  def initialize( logger=nil, path )
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end
    
    @path = path

    ## nb: assume/enfore utf-8 encoding (with or without BOM - byte order mark)
    ## - see worlddb/utils.rb
    @hash = YAML.load( File.read_utf8( @path ))
  end

  attr_reader :logger
  
  def each
    @hash.each do |key_wild, value_wild|
      # normalize
      # - key n value as string (not symbols, bool? int? array?)
      # - remove leading and trailing whitespace
      key   = key_wild.to_s.strip
      value = value_wild.to_s.strip
      
      ### hack - hack - hack -change
      ##  no: in yml  becomes false !!! check how to escape!
      
      key   = 'no' if key   == 'false'
      value = 'no' if value == 'false'
      ### todo: issue warnings
      
      puts ">>#{key}<< >>#{value}<<"
    
      yield( key, value )
    end
  end # method each

end # class HashReader
