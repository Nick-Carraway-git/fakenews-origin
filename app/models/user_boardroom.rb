class UserBoardroom < ApplicationRecord
  belongs_to :user
  belongs_to :boardroom

  validates :user_id, presence: true
  validates :boardroom_id, presence: true
end
