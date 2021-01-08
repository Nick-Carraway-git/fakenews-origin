class Boardroom < ApplicationRecord
  belongs_to :article
  has_many :user_boardrooms
  has_many :users, through: :user_boardrooms
end
