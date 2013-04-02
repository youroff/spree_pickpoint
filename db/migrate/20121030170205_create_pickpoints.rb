class CreatePickpoints < ActiveRecord::Migration
  def change
    create_table :spree_pickpoints do |t|
      t.string :num
      t.string :name
      t.string :lat
      t.string :lng
      t.string :ptype
      t.string :in
      t.string :out
      t.string :city
      t.string :addr
      t.boolean :cash
      t.boolean :card
      t.string :metro
      t.string :sched

      t.timestamps
    end
  end
end
