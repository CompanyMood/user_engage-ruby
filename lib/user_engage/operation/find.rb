require 'user_engage/errors'

module UserEngage
  module Operation
    module Find
      def find(params = {})
        check_for_unsupported_params!(params)
        attributes = get_resource(params)
        new(attributes)
      end

      #####################
      ## Private methods ##
      #####################
      private

      def get_resource(params)
        path = "/#{resource_name}/search/"
        response = UserEngage.client.get(path, params)
        check_for_existing_resource!(response, params)
        JSON.parse(response.body, symbolize_names: true)
      end

      def check_for_existing_resource!(response, params)
        return if response.status == 200
        raise(
          UserEngage::ResourceNotFoundException,
          "No resource with {#{params.inspect}} found!"
        )
      end

      def check_for_unsupported_params!(params)
        unsupported_params = params.keys - supported_find_params
        return if unsupported_params.size.zero?

        raise(
          UserEngage::InvalidFindAttributeException,
          "Unsupported parameter/s used: #{unsupported_params.join(', ')}"
        )
      end
    end
  end
end
