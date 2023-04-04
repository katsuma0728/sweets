class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id,         foreign_key: true
      t.string :shipping_postal_code, null: false, default: ""
      t.string :shipping_address,     null: false, default: ""
      t.string :shipping_name,        null: false, default: ""
      t.integer :postage,             null: false, default: ""
      t.integer :billing_amount,      null: false, default: ""
      t.integer :payment_method,      null: false, default: 0
      t.integer :order_status,        null: false, default: 0

      t.timestamps
    end
  end
end
