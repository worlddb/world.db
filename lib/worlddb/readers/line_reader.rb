# encoding: utf-8

##
## fix/todo: move to/merge into LineReader itself
#   e.g. use  fromString c'tor ??? or similar??

class StringLineReader

  def initialize( logger=nil, data )
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end
    
    @data = data
  end

  attr_reader :logger


  def each_line
    @data.each_line do |line|
  
      if line =~ /^\s*#/
        # skip komments and do NOT copy to result (keep comments secret!)
        logger.debug 'skipping comment line'
        next
      end
        
      if line =~ /^\s*$/ 
        # kommentar oder leerzeile überspringen 
        logger.debug 'skipping blank line'
        next
      end

      # remove leading and trailing whitespace
      line = line.strip
 
      yield( line )
    end # each lines
  end # method each_line

end


class LineReader

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
    @data = File.read_utf8( @path )
  end

  attr_reader :logger


  def each_line
    @data.each_line do |line|
  
      if line =~ /^\s*#/
        # skip komments and do NOT copy to result (keep comments secret!)
        logger.debug 'skipping comment line'
        next
      end
        
      if line =~ /^\s*$/ 
        # kommentar oder leerzeile überspringen 
        logger.debug 'skipping blank line'
        next
      end

      # remove leading and trailing whitespace
      line = line.strip
 
      yield( line )
    end # each lines
  end # method each_line
  
end # class LineReader
