class CreateSupplierProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :supplier_products do |t|
      t.integer :product_id, :supplier_id
      t.boolean :active
      
      t.timestamps
    end
  end
end
