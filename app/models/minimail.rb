class Minimail < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciever_id'
end
