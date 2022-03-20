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
  before_validation :convert_price_to_cents, if: :price_changed?

  # Data validations, even the form include :require => true, this create an extra layer to ensure data received is valid
  validates :listing_name, :condition, :price, :description, :category_id, :shipping, presence: true
  validates :listing_name, length: { minimum: 2 }
  
  # Data sanitsations
  before_save :remove_whitespace
  before_save :censor_profanities

  private 
  
  def remove_whitespace 
    self.listing_name = self.listing_name.strip
    self.description = self.description.strip
  end

  def censor_profanities

    profanities = ["shit", "fuck", "cunt", "sex"]

    def replace_word(bad_word)
      letters = bad_word.split("")
      word_length = letters.length
      sub_chars = ["!", "@", "#", "$", "%", "^", "&", "*"]
      numbers_of_sub_chars = word_length - 2
      sub_word = []
      numbers_of_sub_chars.times { sub_word << sub_chars.sample }
      sub_word.unshift(letters[0])
      sub_word.append(letters[-1])
      @text = sub_word.join
    end

    name_array = self.listing_name.split(" ")
    profanities.each do |prof|
      word = prof.downcase
      replace_word(word)
      self.listing_name = self.listing_name.gsub(word, @text)
      self.description = self.description.gsub(word, @text)
    end

  end
  
  def convert_price_to_cents 
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end 
  
end
