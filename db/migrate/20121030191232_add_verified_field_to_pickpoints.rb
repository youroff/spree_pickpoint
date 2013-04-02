class AddVerifiedFieldToPickpoints < ActiveRecord::Migration
  def change
    add_column :spree_pickpoints, :verified, :boolean
  end
end
