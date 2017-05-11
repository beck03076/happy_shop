class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :sold_out
      t.string :category
      t.boolean :under_sale
      t.integer :price_cents
      t.integer :sale_price_cents

      t.timestamps
    end
  end
end
