class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  enum production_status: { production_not: 0, waiting_production: 1, under_construction: 2, finished: 3 }
end
