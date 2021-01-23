class Minimail < ApplicationRecord
  default_scope->{ order(created_at: :desc) }
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciever_id'

  # reply_idは不要
  validates :sender_id, presence: true
  validates :reciever_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 500 }
end
