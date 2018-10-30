# frozen_string_literal: true

require 'user_engage/resource_collection'
require 'user_engage/errors'

module UserEngage
  module Operation
    module UpdateAttributes
      # Public: Updates attributes of the resource
      #
      # Params: attributes - A hash where
      # the key is the name_std of the attribute to set and
      # the value is the value to set
      #
      def update_attributes(attributes_hash)
        update_remote_attributes!(attributes_hash) &&
          update_local_attributes!(attributes_hash)
      end

      #####################
      ## Private methods ##
      #####################
      private

      # Privates: Generates the destination endpoint and
      # calls it with POST and given attributes.
      #
      def update_remote_attributes!(attributes_hash)
        path = "/#{resource_name}/#{id}/set_multiple_attributes/"
        UserEngage.client.post(path, attributes_hash)
      end

      # Private: Iterates through all attributes and
      # sets it on the instance.
      #
      def update_local_attributes!(attributes_hash)
        attributes_hash.each_pair do |attr_name, attr_value|
          update_local_attribute!(attr_name, attr_value)
        end
      end

      # Private: Search for the resources attribute with the given name
      # and set's it's attribute to the given value.
      #
      def update_local_attribute!(name, value)
        attribute = attributes[:attributes].find do |attr|
          attr.name_std.to_s.eql?(name.to_s)
        end

        if attribute.nil?
          new_attr = UserEngage::Attribute.new(value: value, name: name.to_s)
          attributes[:attributes] << new_attr
        else
          attribute.attributes[:value] = value
        end
      end
    end
  end
end
