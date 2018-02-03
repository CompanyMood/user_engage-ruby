require 'dry-struct'

module UserEngage
  class BaseModel < Dry::Struct
    module Types
      include Dry::Types.module
    end

    constructor_type :schema
  end
end
