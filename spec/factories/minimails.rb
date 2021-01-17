FactoryBot.define do
  factory :minimail do
    sender_id { 1 }
    reciever_id { 2 }
    title { "Title" }
    content { "Content" }
  end
end
