FactoryBot.define do
  factory :chat do
    message { "Hi!" }
    user
    boardroom
  end
end
