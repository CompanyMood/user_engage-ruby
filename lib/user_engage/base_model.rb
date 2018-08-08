require 'dry-struct'

module UserEngage
  class BaseModel < Dry::Struct
    module Types
      include Dry::Types.module
    end

    transform_types do |type|
      type.meta(omittable: true)
    end
  end
end
