class AddTracking < ActiveRecord::Migration
  def change
    add_column :spree_pickpoint_customers, :delivery_tracking, :string
    add_column :spree_pickpoint_customers, :delivery_status, :string
  end
end
