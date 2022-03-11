class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum condition: {brand_new: 1, like_new: 2, great: 3, good: 4, fair: 5}
  enum listing_status: {draft: 1, listed: 2, sold: 3, archived: 4}
  enum shipping: {pending: 1, shipped: 2}

  has_one_attached :picture

end
