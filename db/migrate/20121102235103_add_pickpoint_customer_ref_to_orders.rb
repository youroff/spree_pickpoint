class AddPickpointCustomerRefToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :pickpoint_customer_id, :integer
  end
end
