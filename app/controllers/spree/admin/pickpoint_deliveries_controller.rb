module Spree
  module Admin
    class PickpointDeliveriesController < Spree::Admin::BaseController
      before_filter :load_order
    
      def edit
      end
    
      def load_order
        @order ||= Order.find_by_number(params[:order_id])
        authorize! action, @order
      end
    end
  end
end