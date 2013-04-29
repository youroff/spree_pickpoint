class CreateRegions < ActiveRecord::Migration
  def change
    create_table :spree_pickpoint_regions do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end