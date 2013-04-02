class AddStatusFieldToPickpoints < ActiveRecord::Migration
  def change
    add_column :spree_pickpoints, :status, :integer
  end
end
