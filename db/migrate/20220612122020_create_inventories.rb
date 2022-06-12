class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :product_name
      t.decimal :price
      t.integer :quantity
      t.string :type
      t.string :vendor

      t.timestamps
    end
  end
end
