class RemoveReferenceFromPickpointCustomer < ActiveRecord::Migration
  def change
    change_table :spree_pickpoint_customers do |t|
      t.remove_references :pickpoint
      t.string :pickpoint
    end
  end
end
