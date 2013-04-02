class CreatePickpointCustomers < ActiveRecord::Migration
  def change
    create_table :spree_pickpoint_customers do |t|
      t.references :pickpoint
      t.string :name
      t.string :phone

      t.timestamps
    end
    add_index :spree_pickpoint_customers, :pickpoint_id
  end
end
