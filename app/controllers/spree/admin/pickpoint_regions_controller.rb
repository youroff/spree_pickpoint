module Spree
  module Admin
    class PickpointRegionsController < Spree::Admin::BaseController
      def show
        PickpointRegion.sync(PickpointCity.regions) if params['refresh'].present? 
        @regions = PickpointRegion.all
      end
      
      def update
        ids = []
        prices = []
        params['price'].each do |id, price|
          ids << id
          prices << {:price => price}
        end
        PickpointRegion.update(ids, prices)
        redirect_to :action => 'show', :status => 302
      end
      
      # def update
        # params.each do |name, value|
          # next unless Spree::Config.has_preference? name
          # Spree::Config[name] = value
        # end
      # end
      
    end
  end
end