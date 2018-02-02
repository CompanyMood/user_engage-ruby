module UserEngage
  class BaseModel
    ######################
    ## Instance methods ##
    ######################
    def initialize(attributes)
      attributes.each_pair do |k,v|
        public_send("#{k}=", v)
      end
    end
  end
end
