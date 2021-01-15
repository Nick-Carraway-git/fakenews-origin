class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  has_many :boardrooms
  has_many :favorites, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: true, length: { maximum: 70 }
  validates :content, presence: true, length: { maximum: 4000 }
  validates :image_description, presence: true, length: { maximum: 70 }
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 3.megabytes,
                                    message: "should be less than 3MB" }
  validate  :image_presence

  # 中間テーブルのための関連づけ
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  accepts_nested_attributes_for :article_categories, allow_destroy: true

  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, '形式はjpegかpngを選択して下さい。')
      end
    else
      errors.add(:image, 'ファイルを添付して下さい')
    end
  end
end
