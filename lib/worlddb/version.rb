
module WorldDb

  # sync version w/ sport.db n friends - why? why not?
  MAJOR = 2 ## todo: namespace inside version or something - why? why not??
  MINOR = 0
  PATCH = 7
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "worlddb/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

end

