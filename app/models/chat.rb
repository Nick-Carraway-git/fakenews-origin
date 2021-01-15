class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :boardroom, dependent: :destroy
end
