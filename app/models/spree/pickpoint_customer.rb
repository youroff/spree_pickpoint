#coding: utf-8
module Spree
  class PickpointCustomer < ActiveRecord::Base
    belongs_to :pickpoint, :class_name => 'Spree::Pickpoint', :foreign_key => :pickpoint_num, :primary_key => :num
    has_one :order
    attr_accessible :name, :phone, :pickpoint_num
    
    #TODO: Delivery Tracking, Delivery Status
    
    validates_presence_of :name, :phone
    validates :phone, format: { with: /\A[0-9]{10}\z/, message: "Телефон должен быть указан в формате 10 цифр без \"восьмерки\"" }
    validates_presence_of :pickpoint_num, :message => 'Вы должны выбрать место получения заказа'
    validate :pickpoint_existance
    
    def pickpoint_existance
      return true if pickpoint_num.empty?
      errors.add(:pickpoint_num, "Выбранный пункт получения содержит неверный ID") unless Pickpoint.where(:num => pickpoint_num).exists?
    end
    
    def adjust!
      order.adjustments.where(originator_type: "Spree::PickpointCustomer").delete_all
      order.adjustments.create({ :amount => pickpoint.delivery_price,
                                 :source => order,
                                 # :mandatory => true,
                                 :originator => self,
                                 :locked => true,
                                 :label => "Доставка:" }, :without_protection => true      )
      order.adjustments.create({ :amount => calculate_discount(order),
                                :source => order,
                                # :mandatory => true,
                                :originator => self,
                                :locked => false,
                                :label => "Скидка на доставку:" }, :without_protection => true)
    end
    
    def update_adjustment(adjustment, order)
      adjustment.update_attribute_without_callbacks(:amount, calculate_discount(order))
    end
    
    def calculate_discount(order)
      discount = (order.item_total.to_i > 2000) ? (0.1 * order.item_total.to_i).round : 0
      - ((discount > pickpoint.delivery_price) ? pickpoint.delivery_price : discount)
    end
  end
end