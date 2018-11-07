# frozen_string_literal: true

require 'user_engage/base_model'
require 'user_engage/operation/all'
require 'user_engage/operation/create'
require 'user_engage/operation/find'
require 'user_engage/operation/destroy'
require 'user_engage/operation/update'
require 'user_engage/operation/update_attributes'

require 'user_engage/attribute'
require 'user_engage/list'
require 'user_engage/tag'

module UserEngage
  class User < BaseModel
    ##############
    ## Includes ##
    ##############
    extend Operation::All
    extend Operation::Create
    extend Operation::Find
    include Operation::Destroy
    include Operation::Update
    include Operation::UpdateAttributes

    ################
    ## Attributes ##
    ################
    attribute :attributes, Types::Coercible::Array.of(UserEngage::Attribute)
    attribute :browser, Types::String
    attribute :browser_language, Types::String
    attribute :chat_id, Types::Integer
    attribute :city, Types::String
    attribute :companies, Types::Coercible::Array.of(UserEngage::Company)
    attribute :country, Types::String
    attribute :created_at, Types::DateTime
    attribute :email, Types::String
    attribute :facebook_url, Types::String
    attribute :first_seen, Types::DateTime
    attribute :gender, Types::String
    attribute :google_url, Types::String
    attribute :gravatar_url, Types::String
    attribute :id, Types::Integer
    attribute :key, Types::String
    attribute :last_contacted, Types::DateTime
    attribute :last_ip, Types::String
    attribute :last_seen, Types::DateTime
    attribute :linkedin_url, Types::String
    attribute :lists, Types::Coercible::Array.of(UserEngage::List)
    attribute :name, Types::String
    attribute :notifications, Types::Bool
    attribute :os_type, Types::String
    attribute :page_views, Types::Integer
    attribute :phone_number, Types::String
    attribute :region, Types::String
    attribute :resolution, Types::String
    attribute :score, Types::Integer
    attribute :status, Types::String
    attribute :tags, Types::Coercible::Array.of(UserEngage::Tag)
    attribute :timezone, Types::String
    attribute :twitter_url, Types::String
    attribute :unsubscribed, Types::Bool
    attribute :updated_at, Types::DateTime
    attribute :user_id, Types::Any

    ###################
    ## Class methods ##
    ###################
    def self.resource_name
      'users'
    end

    #####################
    ## Private methods ##
    #####################
    private_class_method def self.supported_find_params
      %i[email key phone_number date user_id]
    end

    private_class_method def self.required_params
      %i[email]
    end
  end
end
