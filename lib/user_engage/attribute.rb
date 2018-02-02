require 'user_engage/base_model'

module UserEngage
  class Attribute < BaseModel
    ################
    ## Attributes ##
    ################
    attr_accessor :name_std, :name, :value, :id, :description
  end
end
