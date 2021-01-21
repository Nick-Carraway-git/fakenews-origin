class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :boardroom

  validates :message, presence: true, length: { maximum: 100 }
end
