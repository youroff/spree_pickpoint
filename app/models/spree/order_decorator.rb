#coding: utf-8
module Spree
  Order.class_eval do
    
    checkout_flow do
      go_to_state :pickpoint
      go_to_state :payment, :if => lambda { |order| order.payment_required? }
      go_to_state :confirm #, :if => lambda { |order| order.confirmation_required? }
      go_to_state :complete
      #remove_transition :from => :pickpoint, :to => :complete
    end
    
    state_machine do
      after_transition :from => :pickpoint do |order|
        order.pickpoint_customer.adjust!
      end
      #       # after_transition :from => :pickpoint,  :do => :default_shipping_method!
      # after_transition :from => :pickpoint,  :do => :create_shipment!
    end
    
    belongs_to :pickpoint_customer
    attr_accessible :pickpoint_customer, :pickpoint_customer_attributes
    accepts_nested_attributes_for :pickpoint_customer
    
    def empty!
      line_items.destroy_all
    end
    
    def pickpoint
      pickpoint_customer ? pickpoint_customer.pickpoint : nil
    end
    
    # def available_shipping_methods(display_on = nil)
    #   ShippingMethod.all_available(self, display_on)
    # end
  end
end