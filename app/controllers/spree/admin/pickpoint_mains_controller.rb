module Spree
  module Admin
    class PickpointMainsController < Spree::Admin::BaseController
      
      respond_to :html
      before_filter :load_point
      
      def show
      end
      
      def update
        if @point.update_attributes(params[:pickpoint])
          flash[:success] = flash_message_for(@point, :successfully_updated)
          respond_with(@point) do |format|
            format.html { redirect_to admin_pickpoint_main_url }
          end
        else
          respond_with(@point)
        end
      end
      
      private
      def load_point
        @point = Pickpoint.find_or_create_by_num('0000')
      end
    end
  end
end