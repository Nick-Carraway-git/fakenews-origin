class UserBoardroom < ApplicationRecord
  belongs_to :user
  belongs_to :boardroom
end
