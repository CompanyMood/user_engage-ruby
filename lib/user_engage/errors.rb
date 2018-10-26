# frozen_string_literal: true

module UserEngage
  class InvalidFindAttributeException < StandardError; end
  class ResourceNotFoundException < StandardError; end
  class NotExistingResourceException < StandardError; end
  class NoNextPageAvailableException < StandardError; end
  class NoPreviousPageAvailableException < StandardError; end
end
