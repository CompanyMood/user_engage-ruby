# frozen_string_literal: true

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
        response = if params.is_a?(Integer)
                     get_by_id(params)
                   else
                     get_by_hash(params)
                   end

        check_for_existing_resource!(response, params)
        JSON.parse(response.body, symbolize_names: true)
      end

      def get_by_hash(params)
        path = "/#{resource_name}/search/"
        UserEngage.client.get(path, params)
      end

      def get_by_id(id)
        path = "/#{resource_name}/#{id}/"
        UserEngage.client.get(path)
      end

      def check_for_existing_resource!(response, params)
        return if response.status == 200

        raise(
          UserEngage::ResourceNotFoundException,
          "No resource with {#{params.inspect}} found!"
        )
      end

      def check_for_unsupported_params!(params)
        if params.is_a?(Integer)
          true
        else
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
end
