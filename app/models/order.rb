class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_confirmation: 1, under_construction: 2, preparing_to_ship: 3, sent: 4 }

  def get_ordered_count(order_id)
    oder_items = OrderItem.where(order_id: order_id)
    total = 0
    order_items.each do |order_item|
      total += order_item.amount
    end
    return total
  end

  def order_shipping_display
    '〒' + self.shipping_postal_code + ' ' + self.shipping_address + ' ' + self.shipping_name
  end
  
end