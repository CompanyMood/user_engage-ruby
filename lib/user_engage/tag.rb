require 'user_engage/base_model'

module UserEngage
  class Tag < BaseModel
    ################
    ## Attributes ##
    ################
    attr_accessor :id, :name
  end
end
