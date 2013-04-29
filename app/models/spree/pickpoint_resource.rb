module Spree
  class PickpointResource < ActiveResource::Base
    include ActiveResource::Extend::WithoutExtension
    
    self.site = PickpointConfiguration.test_mode ? PickpointConfiguration.test_api_url : PickpointConfiguration.api_url
    
    private
    def config
      
    end
  end
end

