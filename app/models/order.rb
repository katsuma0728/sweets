class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_confirmation: 1, under_construction: 2, preparing_to_ship: 3, sent: 4 }
  enum shipping_address: { me_address: 0, registered_address: 1, new_delivery: 2 }
end