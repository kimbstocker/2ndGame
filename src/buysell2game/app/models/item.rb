class Item < ApplicationRecord
  belongs_to :listing
  belongs_to :order
end
