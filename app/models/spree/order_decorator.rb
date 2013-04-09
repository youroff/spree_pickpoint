#coding: utf-8
module Spree
  Order.class_eval do
    
    checkout_flow do
      go_to_state :pickpoint
      go_to_state :payment, :if => lambda { |order| order.payment_required? }
      go_to_state :confirm #, :if => lambda { |order| order.confirmation_required? }
      go_to_state :complete
      remove_transition :from => :pickpoint, :to => :complete
    end
    
    state_machine do
      after_transition :from => :pickpoint do |order|
        order.pickpoint_customer.adjust!
      end
      # after_transition :to => :payment, :do => :clean_pending_payments!
      after_transition :from => :confirm, :do => :update_payment_amount!
    end
    
    belongs_to :pickpoint_customer
    attr_accessible :pickpoint_customer, :pickpoint_customer_attributes
    accepts_nested_attributes_for :pickpoint_customer
    
    def pickpoint
      pickpoint_customer ? pickpoint_customer.pickpoint : nil
    end
    
    def update_payment_amount!
      payment = pending_payments.last
      payment.amount = total
      payment.save
      payments.where(["identifier != ?", payment.identifier]).delete_all
    end
    
    # def clean_pending_payments!
    #   payments.delete_all
    # end
  end
end