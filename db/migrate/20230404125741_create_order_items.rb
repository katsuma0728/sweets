class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      
      t.integer :item_id, foreign_key: true
      t.integer :order_id, foreign_key: true
      t.integer :purchase_price, null: false, default: ""
      t.integer :amount, null: false, default: ""
      t.integer :production_status, null: false, default: 0

      t.timestamps
    end
  end
end
