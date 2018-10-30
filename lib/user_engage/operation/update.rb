# frozen_string_literal: true

module UserEngage
  module Operation
    module Update
      # Public: Updates the resources attributes (not the array)
      # with the given attributes_hash.
      #
      def update(attributes_hash)
        update_remote!(attributes_hash) &&
          update_locally!(attributes_hash)
      end

      #####################
      ## Private methods ##
      #####################
      private

      # Private: Request the update of the attributes on UE
      #
      def update_remote!(attributes_hash)
        path = "/#{resource_name}/#{id}/"
        UserEngage.client.put(path, attributes_hash)
      end

      # Private: Updates the instances attributes
      #
      def update_locally!(attributes_hash)
        attributes_hash.each_pair do |attr_name, value|
          attributes[attr_name.to_sym] = value
        end
      end
    end
  end
end
