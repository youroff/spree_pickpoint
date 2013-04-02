module Spree
  class PickpointsController < BaseController
    respond_to :json
    
    def show
      @pickpoint = Pickpoint.find(params[:id])
    end
  end
end