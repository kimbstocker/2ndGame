class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum condition: { brand_new_mint: 1, like_new: 2, great: 3, good: 4, fair: 5 }
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
  before_save :censor_profanities
  before_validation :convert_price_to_cents, if: :price_changed?

  private 
  
  def remove_whitespace 
    self.listing_name = self.listing_name.strip
    self.description = self.description.strip
  end

  def censor_profanities
    # self.listing_name = ProfanityFilter.new
    # self.description = ProfanityFilter.new
    # if self.listing_name.profane?
    #   flash[:alert] = "Please do not use profanities"
    # end

    # symbols = ["#", "$", "*", "@", "!", "%"]
    # profanities = ["shit", ]
    # self.title = self.title.gsub(/covid/i, "pfizer")
    # self.description = self.title.gsub(/covid/i, "pfizer")
    # sj.censor(self.listing_name)
    # sj.censor(self.description)

  end
  
  def convert_price_to_cents 
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end 
  
end
