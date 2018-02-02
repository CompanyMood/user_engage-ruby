require 'user_engage/errors'

module UserEngage
  module Operation
    module Find
      def find(params={})
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
        JSON.parse(response.body)
      end

      def check_for_existing_resource!(response, params)
        fail UserEngage::ResourceNotFoundException.new(
          "No resource with {#{params.inspect} found!}"
        ) unless response.status == 200
      end

      def check_for_unsupported_params!(params)
        unsupported_params = params.keys - supported_find_params

        if unsupported_params.size > 0
          fail UserEngage::InvalidFindAttributeException.new(
            "Unsupported parameter/s used: #{unsupported_params.join(', ')}"
          )
        end
      end
    end
  end
end
