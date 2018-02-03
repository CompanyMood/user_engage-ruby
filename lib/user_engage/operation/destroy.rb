require 'user_engage/errors'

module UserEngage
  module Operation
    module Destroy
      def destroy
        destroy_resource
      end

      #####################
      ## Private methods ##
      #####################
      private

      def destroy_resource
        path = "/#{self.class.resource_name}/#{id}/"
        response = UserEngage.client.delete(path)
        check_for_success!(response)
      end

      def check_for_success!(response)
        return true if response.status == 204
        raise(
          UserEngage::NotExistingResourceException,
          "No resource with ID: #{id} found!"
        )
      end
    end
  end
end
