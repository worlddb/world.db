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
    
    text = File.read_utf8( @path )
   
    ### hack for syck yaml parser (e.g.ruby 1.9.2) (cannot handle !!null)
    ##   change it to !null to get plain nil
    ##   w/ both syck and psych/libyml

    text = text.gsub( '!!null', '!null' )
   
    ### hacks for yaml
    
    ### see yaml gotschas
    ##  - http://www.perlmonks.org/?node_id=738671
    ##  - 

    ## replace all tabs w/ two spaces and issue a warning
    ## nb: yaml does NOT support tabs see why here -> yaml.org/faq.html
    
    text = text.gsub( "\t" ) do |_|
      puts "*** warn: hash reader - found tab (\t) replacing w/ two spaces; yaml forbids tabs; see yaml.org/faq.html"
      '  '  # replace w/ two spaces
    end

    ## quote implicit boolean types on,no,n,y
    
    text = text.gsub( /\b(ON|On|on|NO|No|no|N|n|Y|y)\b/ ) do |value|
      puts "*** warn: hash reader - found implicit bool (#{$1}); adding quotes to turn into string; see yaml.org/refcard.html"
      "'#{$1}'"  # add quotes to turn it into a string (not bool e.g. true|false)
    end
    
    @hash = YAML.load( text )
  end

  attr_reader :logger
  
  def each
    @hash.each do |key_wild, value_wild|
      # normalize
      # - key n value as string (not symbols, bool? int? array?)
      # - remove leading and trailing whitespace
      key   = key_wild.to_s.strip
      value = value_wild.to_s.strip
      
      puts ">>#{key}<< >>#{value}<<"
    
      yield( key, value )
    end
  end # method each

end # class HashReader
