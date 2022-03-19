class Order < ApplicationRecord
  belongs_to :user
  has_many :items

  enum order_status: { pending: 1, paid_await_shipping: 2, shipped: 3, archived: 4 }
  has_one :payment
end
