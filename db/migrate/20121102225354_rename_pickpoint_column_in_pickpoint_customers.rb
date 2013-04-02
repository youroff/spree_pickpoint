class RenamePickpointColumnInPickpointCustomers < ActiveRecord::Migration
  def change
    rename_column :spree_pickpoint_customers, :pickpoint, :pickpoint_num
  end
end
