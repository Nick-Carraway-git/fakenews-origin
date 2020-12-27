class Article < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true

  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  accepts_nested_attributes_for :article_categories, allow_destroy: true
end
