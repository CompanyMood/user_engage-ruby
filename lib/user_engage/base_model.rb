# frozen_string_literal: true

require 'dry-struct'

module UserEngage
  class BaseModel < Dry::Struct
    module Types
      include Dry::Types.module
    end

    transform_types do |type|
      type.meta(omittable: true)
    end

    def resource_name
      self.class.resource_name
    end
  end
end
