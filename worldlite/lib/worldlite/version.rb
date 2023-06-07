# encoding: utf-8


module WorldLite
  
  MAJOR   = 0
  MINOR   = 0
  PATCH   = 4
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.banner
    "worldlite/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

end

