class Boardroom < ApplicationRecord
  belongs_to :article
  default_scope -> { order(created_at: :desc) }
  has_many :user_boardrooms
  has_many :users, through: :user_boardrooms
  has_many :chats
end