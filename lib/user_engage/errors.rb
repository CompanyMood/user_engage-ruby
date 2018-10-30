# frozen_string_literal: true

module UserEngage
  class CreateNotSuccessfulException < StandardError; end
  class InvalidFindAttributeException < StandardError; end
  class NotExistingResourceException < StandardError; end
  class NoNextPageAvailableException < StandardError; end
  class NoPreviousPageAvailableException < StandardError; end
  class ResourceNotFoundException < StandardError; end
end
