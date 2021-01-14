class Favorite < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :article, dependent: :destroy

  validates :user_id, presence: true
  validates :article_id, presence: true
end
