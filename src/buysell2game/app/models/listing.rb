class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum condition: { brand_new: 1, like_new: 2, great: 3, good: 4, fair: 5 }
  enum listing_status: { draft: 1, listed: 2, sold: 3, archived: 4 }
  enum shipping: { post_only: 1, pick_up_only: 2, aus_post_or_pick_up: 3 }

  has_one_attached :picture

  # has_many_attached :picture
  has_one :item

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourite

  # Data validations, even the form include :require => true, this create an extra layer to ensure data received is valid
  validates :listing_name, :condition, :price, :description, :category_id, :shipping, presence: true
  validates :listing_name, length: { minimum: 2 }

  # Data sanitsations
  before_save :remove_whitespace
  before_save :remove_covid
  before_validation :price_round

  private 
  
  def remove_whitespace 
    self.title = self.title.strip
    self.description = self.description.strip
  end
  
  def remove_covid 
    self.title = self.title.gsub(/covid/i, "pfizer")
    self.description = self.title.gsub(/covid/i, "pfizer")
  end
  
  def price_round 
    self.price = (self.attributes_before_type_cast["price"]).round
  end 
  
end
