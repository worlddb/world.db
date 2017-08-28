
module WorldDBService

  VERSION='0.1.0'

  def self.banner
    "worlddb-service #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end

end
