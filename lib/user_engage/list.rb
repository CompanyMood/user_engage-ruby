require 'user_engage/base_model'

module UserEngage
  class List < BaseModel
    ################
    ## Attributes ##
    ################
    attribute :id, Types::Integer
    attribute :name, Types::String
    attribute :description, Types::String
  end
end
