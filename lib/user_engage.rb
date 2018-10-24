# frozen_string_literal: true

require 'user_engage/client'
require 'user_engage/configuration'
require 'user_engage/version'

require 'user_engage/list'
require 'user_engage/tag'
require 'user_engage/user'

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
