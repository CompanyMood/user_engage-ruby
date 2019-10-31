# frozen_string_literal: true

require 'dry-struct'

module UserEngage
  class BaseModel < Dry::Struct
    module Types
      include Dry.Types(default: :nominal)
    end

    transform_types(&:omittable)

    def resource_name
      self.class.resource_name
    end
  end
end
