# frozen_string_literal: true

require 'faraday'

module UserEngage
  class Client
    ######################
    ## Instance methods ##
    ######################
    def initialize(configuration)
      @configuration = configuration
    end

    # Public: Calls the base_url with the given path and parameters
    #
    def get(path, parameters = {})
      request(:get, path, parameters)
    end

    # Public: Calls the base_url with the given path and parameters
    #
    def delete(path)
      request(:delete, path)
    end

    #####################
    ## Private methods ##
    #####################
    private

    def connection
      Faraday.new(url: host)
    end

    def request(method, action_path, parameters = nil)
      path = action_path.match?(/^https?/) ?
        action_path :
        "api/public#{action_path}"

      connection.public_send(method, path, parameters) do |request|
        request.headers['Authorization'] = "Token #{@configuration.token}"
        request.headers['Content-Type'] = 'application/json'
        request.headers['User-Agent'] = "UserEngage-Ruby/#{UserEngage::VERSION}"
      end
    end

    def host
      'https://app.userengage.com/'
    end
  end
end
