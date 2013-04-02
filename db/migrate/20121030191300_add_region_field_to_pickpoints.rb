class AddRegionFieldToPickpoints < ActiveRecord::Migration
  def change
    add_column :spree_pickpoints, :region, :string
  end
end
