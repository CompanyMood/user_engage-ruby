require 'user_engage/base_model'

module UserEngage
  class List < BaseModel
    ################
    ## Attributes ##
    ################
    attr_accessor :id, :name, :description
  end
end
