require 'user_engage/base_model'
require 'user_engage/operation/find'

require 'user_engage/attribute'
require 'user_engage/list'
require 'user_engage/tag'

module UserEngage
  class User < BaseModel
    ##############
    ## Includes ##
    ##############
    extend Operation::Find

    ################
    ## Attributes ##
    ################
    attr_accessor :facebook_url, :region, :notifications, :last_ip, :country,
      :resolution, :name, :browser_language, :email, :os_type, :created_at,
      :unsubscribed, :timezone, :gravatar_url, :chat_id, :browser, :key,
      :id, :updated_at, :score, :google_url, :city, :first_seen, :status,
      :gender, :linkedin_url, :twitter_url, :last_contacted, :phone_number,
      :last_seen, :page_views, :user_id

    attr_reader :lists, :attributes, :tags

    def attributes=(attributes_array)
      @attributes = attributes_array.collect do |data|
        UserEngage::Attribute.new(data)
      end
    end

    def lists=(lists_array)
      @lists = lists_array.collect do |data|
        UserEngage::List.new(data)
      end
    end

    def tags=(tags_array)
      @tags = tags_array.collect do |data|
        UserEngage::Tag.new(data)
      end
    end

    #####################
    ## Private methods ##
    #####################
    private

    def self.supported_find_params
      %i{email key phone_number date}
    end

    def self.resource_name
      'users'.freeze
    end
  end
end
