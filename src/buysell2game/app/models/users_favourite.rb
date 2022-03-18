class UsersFavourite < ApplicationRecord
  belongs_to :listing
  belongs_to :user
end
