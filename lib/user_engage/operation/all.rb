# frozen_string_literal: true

require 'user_engage/resource_collection'
require 'user_engage/errors'

module UserEngage
  module Operation
    module All
      def all
        data = fetch_all.merge!(base_class: self)
        UserEngage::ResourceCollection.new(data).tap(&:transform_results!)
      end

      #####################
      ## Private methods ##
      #####################
      private

      def fetch_all
        response = UserEngage.client.get("/#{resource_name}/")
        JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
