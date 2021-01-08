FactoryBot.define do
  factory :chat do
    message { "MyText" }
    user { nil }
    boardroom { nil }
  end
end
