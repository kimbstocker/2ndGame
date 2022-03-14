class Order < ApplicationRecord
  belongs_to :user_id

  enum order_status: {pending: 1, paid_await_shipping: 2, shipped: 3, archived: 4}
  has_many :items
end
