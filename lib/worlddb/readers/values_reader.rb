# encoding: utf-8

class ValuesReader

  def initialize( logger, path, more_values={} )
    ## todo: check - can we make logger=nil a default arg too?
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end
    
    @path = path

    @more_values = more_values

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


      # pass 1) remove possible trailing eol comment
      ##  e.g    -> nyc, New York   # Sample EOL Comment Here (with or without commas,,,,)
      ## becomes -> nyc, New York

      line = line.sub( /\s+#.+$/, '' )

      # pass 2) remove leading and trailing whitespace
      
      line = line.strip

      puts "line: >>#{line}<<"

      values = line.split(',')
      
      # pass 1) remove leading and trailing whitespace for values

      values = values.map { |value| value.strip }

      ##### todo remove support of comment column? (NB: must NOT include commas)
      # pass 2) remove comment columns
      
      values = values.select do |value|
        if value =~ /^#/  ## start with # treat it as a comment column; e.g. remove it
          puts "   removing column with value >>#{value}<<"
          false
        else
          true
        end
      end
      
      puts "  values: >>#{values.join('<< >>')}<<"
      
      
      ### todo/fix: allow check - do NOT allow mixed use of with key and w/o key
      ##  either use keys or do NOT use keys; do NOT mix in a single fixture file
      
      
      ### support autogenerate key from first title value
      if values[0] =~ /^[a-z]{2,}$/   # if it looks like a key (only a-z lower case allowed); assume it's a key
        key_col         = values[0]
        title_col       = values[1]
        more_cols       = values[2..-1]
      else
        key_col         = '<auto>'
        title_col       = values[0]
        more_cols       = values[1..-1]
      end

      attribs = {}

      ## title (split of optional synonyms)
      # e.g. FC Bayern Muenchen|Bayern Muenchen|Bayern
      titles = title_col.split('|')
      
      attribs[ :title ]    =  titles[0]
     
      ## add optional synonyms if present
      attribs[ :synonyms ] =  titles[1..-1].join('|')  if titles.size > 1
      
      if key_col == '<auto>'
        ## autogenerate key from first title
        key_col = title_to_key( titles[0] )
        puts "   autogen key >#{key_col}< from title >#{titles[0]}<"
      end
      
      attribs[ :key ] = key_col
      
      attribs = attribs.merge( @more_values )  # e.g. merge country_id and other defaults if present
                        
      yield( attribs, more_cols )

    end # each lines

  end # method each_line
  
  

  def title_to_key( title )

      ## NB: downcase does NOT work for accented chars (thus, include in alternatives)
      key = title.downcase

      ### remove optional english translation in square brackets ([]) e.g. Wien [Vienna]
      key = key.gsub( /\[.+\]/, '' )

      ## remove optional longer title part in () e.g. Las Palmas (de Gran Canaria), Palma (de Mallorca)
      key = key.gsub( /\(.+\)/, '' )

      ## remove all whitespace and punctuation
      key = key.gsub( /[ \t_\-\.()\[\]'"\/]/, '' )

      ##  turn accented char into ascii look alike if possible
      ##
      ## todo: add some more
      ## see http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references  for more
      
      alternatives = [
        ['ß', 'ss'],
        ['æ', 'ae'],
        ['ä', 'ae'],  
        ['á', 'a' ],  # e.g. Bogotá, Králové
        ['ã', 'a' ],  # e.g  São Paulo
        ['ă', 'a' ],  # e.g. Chișinău
        ['é', 'e' ],  # e.g. Vélez, Králové
        ['è', 'e' ],  # e.g. Rivières
        ['ê', 'e' ],  # e.g. Grêmio
        ['ě', 'e' ],  # e.g. Budějovice
        ['ì', 'i' ],  # e.g. Potosì
        ['í', 'i' ],  # e.g. Ústí
        ['ñ', 'n' ],  # e.g. Porteño
        ['ň', 'n' ],  # e.g. Plzeň, Třeboň
        ['ö', 'oe'],  
        ['ó', 'o' ],  # e.g. Colón, Łódź, Kraków
        ['ř', 'r' ],  # e.g. Třeboň
        ['ș', 's' ],  # e.g. Chișinău
        ['ü', 'ue'],  
        ['ú', 'u' ],  # e.g. Fútbol
        ['ź', 'z' ],  # e.g. Łódź
        ['Č', 'c' ],  # e.g. České
        ['Ł', 'l' ],  # e.g. Łódź
        ['Ú', 'u' ],  # e.g. Ústí
      ]
      
      alternatives.each do |alt|
        key = key.gsub( alt[0], alt[1] )
      end

      key
  end # method title_to_key

  
end # class ValuesReader