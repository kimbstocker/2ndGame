class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum condition: {brand_new: 1, like_new: 2, great: 3, good: 4, fair: 5}
end
