

def find_world_db_path_from_gemfile_gitref!
  puts "[debug] find_world_db_path..."
  puts "load path:"
  pp $LOAD_PATH
  
  candidates = []
  $LOAD_PATH.each do |path|
    
    # nb: avoid matching /world.db.ruby/ (e.g. gem "worlddb", "0.10.0", :path => "../world.db.ruby")
    
    if path =~ /\/(world\.db-[a-z0-9]+)|(world\.db)\//
      candidates << path.dup
    end
  end
  
  puts "found candidates:"
  pp candidates
  
  cand = candidates[0]
  
  puts "cand before: #{cand}"
  
  ## nb: *? is non-greedy many operator
  
  ## todo: why not just cut off trailing /lib - is it good enough??
  # it's easier  
  
  regex = /(\/world\.db.*?)(\/.*)/
  cand = cand.sub( regex ) do |_|
    puts "cutting off >>#{$2}<<"
    $1
  end
  
  puts "cand after: #{cand}"
  
  ## todo:exit with error if not found!!!
  
  cand
end
