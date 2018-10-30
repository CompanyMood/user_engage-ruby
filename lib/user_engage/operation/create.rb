# frozen_string_literal: true

require 'user_engage/errors'

module UserEngage
  module Operation
    module Create
      # Public: Creates a new resource instance, create a new resource
      # through UE API and returns the insance.
      #
      def create(attributes_hash)
        check_for_required_params!(attributes_hash)
        response = create_remote_resource(attributes_hash)
        check_for_response_code!(response)
        construct_new_resource(response)
      end

      #####################
      ## Private methods ##
      #####################
      private

      # Private: Sends the post request with the UE client
      # and returns the response
      #
      def create_remote_resource(attributes_hash)
        path = "/#{resource_name}/"
        UserEngage.client.post(path, attributes_hash)
      end

      # Private: Creates a new resource instance with
      # the body of the given response.
      #
      def construct_new_resource(response)
        data = JSON.parse(response.body, symbolize_names: true)
        new(data)
      end

      # Private: Checks for 201 status.
      # If not 200 a UserEngage::CreateNotSuccessfulException with
      # given message gets returned.
      #
      def check_for_response_code!(response)
        return if response.status == 201

        raise(
          UserEngage::CreateNotSuccessfulException,
          response.body
        )
      end

      # Private: Checks for the set required_params
      # and raises an CreateNotSuccessfulException with a message
      # if not all are given.
      #
      def check_for_required_params!(attributes_hash)
        return if (
          missing_attributes = required_params - attributes_hash.keys
        ).empty?

        raise(
          UserEngage::CreateNotSuccessfulException,
          "Missing attributes {#{missing_attributes.inspect}}"
        )
      end
    end
  end
end
