require 'user_engage/version'
require 'user_engage/configuration'

module UserEngage
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    yield(configuration)
  end
end
