require 'user_engage/client'
require 'user_engage/configuration'
require 'user_engage/version'

module UserEngage
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    yield(configuration)
  end

  def self.client
    Client.new(configuration)
  end
end
