class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,           foreign_key: true
      t.string :name,               null: false
      t.text :detail,               null: false
      t.integer :category_id,       null: false
      t.integer :item_status_id,    null: false
      t.integer :shipping_fee_id,   null: false
      t.integer :prefecture_id,     null: false
      t.integer :days_to_ship_id,      null: false
      t.integer :price,             null: false
      t.timestamps
    end
  end
end
