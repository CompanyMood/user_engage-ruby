require 'user_engage/base_model'

module UserEngage
  class Tag < BaseModel
    ################
    ## Attributes ##
    ################
    attribute :id, Types::Integer
    attribute :name, Types::String
  end
end
