class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  has_many :boardrooms
  has_many :favorites, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 70 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 3.megabytes,
                                    message: "should be less than 3MB" }

  # 中間テーブルのための関連づけ
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  accepts_nested_attributes_for :article_categories, allow_destroy: true
end
