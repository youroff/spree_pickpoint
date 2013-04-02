#coding: utf-8
module Spree
  CheckoutController.class_eval do

    def before_pickpoint
      @order.pickpoint_customer ||= PickpointCustomer.new
    end
  end
end