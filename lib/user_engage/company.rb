# frozen_string_literal: true

require 'user_engage/base_model'
require 'user_engage/operation/all'
require 'user_engage/operation/create'
require 'user_engage/operation/find'
require 'user_engage/operation/destroy'
require 'user_engage/operation/update_attributes'

require 'user_engage/attribute'

module UserEngage
  class Company < BaseModel
    ##############
    ## Includes ##
    ##############
    extend Operation::All
    extend Operation::Find
    extend Operation::Create
    include Operation::Destroy
    include Operation::UpdateAttributes

    ################
    ## Attributes ##
    ################
    attribute :address, Types::String
    attribute :approx_employees, Types::Integer
    attribute :attributes, Types::Array.of(UserEngage::Attribute)
    attribute :city, Types::String
    attribute :company_id, Types::Integer
    attribute :country, Types::String
    attribute :created_at, Types::DateTime
    attribute :description, Types::String
    attribute :email, Types::String
    attribute :extra_data, Types::Array
    attribute :id, Types::Integer
    attribute :member_since, Types::DateTime
    attribute :name, Types::String
    attribute :phone_numbers, Types::Array.of(Types::String)
    attribute :postal_code, Types::String
    attribute :region, Types::String
    attribute :updated_at, Types::DateTime

    ###################
    ## Class methods ##
    ###################
    def self.resource_name
      'companies'
    end

    #####################
    ## Private methods ##
    #####################
    private_class_method def self.supported_find_params
      []
    end

    private_class_method def self.required_params
      %i[name]
    end
  end
end
