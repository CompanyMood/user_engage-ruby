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

    # Public: Calls the base_url with the given path and parameters
    #
    def post(path, parameters = {})
      request(:post, path, parameters)
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

      %i[post put patch].include?(method) ?
        json_body_call(method, path, parameters) :
        path_params_call(method, path, parameters)
    end

    def path_params_call(method, path, parameters)
      connection.public_send(method, path, parameters) do |request|
        request.headers['Authorization'] = "Token #{@configuration.token}"
        request.headers['Content-Type'] = 'application/json'
        request.headers['User-Agent'] = "UserEngage-Ruby/#{UserEngage::VERSION}"
      end
    end

    def json_body_call(method, path, parameters)
      connection.public_send(method, path) do |request|
        request.headers['Authorization'] = "Token #{@configuration.token}"
        request.headers['Content-Type'] = 'application/json'
        request.headers['User-Agent'] = "UserEngage-Ruby/#{UserEngage::VERSION}"
        request.body = parameters.to_json
      end
    end

    def host
      'https://app.userengage.com/'
    end
  end
end
