class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :boardroom, dependent: :destroy

  validates :message, presence: true, length: { maximum: 120 }
  validates :user_id, presence: true
  validates :boardroom_id, presence: true
end
