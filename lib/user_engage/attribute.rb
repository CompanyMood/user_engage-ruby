# frozen_string_literal: true

require 'user_engage/base_model'

module UserEngage
  class Attribute < BaseModel
    ################
    ## Attributes ##
    ################
    attribute :description, Types::String
    attribute :id, Types::Integer
    attribute :name_std, Types::String
    attribute :name, Types::String
    attribute :value, Types::Any
  end
end
