# frozen_string_literal: true

require 'user_engage/base_model'
require 'user_engage/errors'

module UserEngage
  class ResourceCollection < BaseModel
    ################
    ## Attributes ##
    ################
    attribute :base_class, Types::Class
    attribute :count, Types::Integer
    attribute :current_page, Types::Integer.default(1)
    attribute :next, Types::String
    attribute :previous, Types::String
    attribute :results, Types::Array

    ######################
    ## Instance methods ##
    ######################

    # Public: Transforms the results Hash to base_class instances
    #
    def transform_results!
      @attributes[:results] = results.collect do |result|
        base_class.new(result)
      end
    end

    # Public: Request next pages resources and increase the current_page.
    # Throws an UserEngage::NoNextPageAvailable if no next page is available
    #
    def go_next!
      check_page_availability!(:next)

      response = UserEngage.client.get(self.next)
      update_page_related_attributes!(response)

      @attributes[:current_page] += 1

      self
    end

    # Public: Request previous pages resources and increase the current_page.
    # Throws an UserEngage::NoPreviousPageAvailable if no next page is available
    #
    def go_previous!
      check_page_availability!(:previous)

      response = UserEngage.client.get(previous)
      update_page_related_attributes!(response)

      @attributes[:current_page] -= 1
      self
    end

    # Public: Iterates through whole collection and
    # yield with each element.
    # Goes to next page and continues to iterate,
    # if a next page is still available
    #
    def each
      loop do
        results.each do |result|
          yield(result)
        end
        go_next!
      end
    rescue UserEngage::NoNextPageAvailableException
      true
    end

    #####################
    ## Private methods ##
    #####################
    private

    # Private: Checks the given type of page availability.
    # If not present, it raises an UserEngage::NoNextPageAvailable
    # or NoPreviousPageAvailable
    #
    def check_page_availability!(type)
      return unless @attributes[type.to_sym].nil?

      raise(
        type.eql?(:next) ?
          UserEngage::NoNextPageAvailableException :
          UserEngage::NoPreviousPageAvailableException,
        "No #{type} page available"
      )
    end

    # Private: This parses given responses body's JSON,
    # sets the collectionss attributes from that
    # JSON response and transform the results array
    # to a collection of base_class instances.
    #
    # Following attributes get set:
    #   * next
    #   * previous
    #   * results
    def update_page_related_attributes!(response)
      data = JSON.parse(response.body, symbolize_names: true)
      @attributes[:next] = data[:next]
      @attributes[:previous] = data[:previous]
      @attributes[:results] = data[:results]
      transform_results!
    end
  end
end
