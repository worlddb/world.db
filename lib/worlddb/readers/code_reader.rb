# encoding: utf-8

class CodeReader

  def initialize( logger=nil, path )
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end

    @path  = path

    ## nb: assume/enfore utf-8 encoding (with or without BOM - byte order mark)
    ## - see worlddb/utils.rb
    
    @code  = File.read_utf8( @path )
  end
  
  def eval( klass )
    klass.class_eval( @code )

    # NB: same as
    #
    # module WorldDB
    #   include WorldDB::Models
    #  <code here>
    # end
  end

  attr_reader :logger

end # class CodeReader