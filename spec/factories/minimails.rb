FactoryBot.define do
  factory :minimail do
    sender_id { 1 }
    reciever_id { 1 }
    reply_id { 1 }
    title { "MyText" }
    content { "MyText" }
  end
end
