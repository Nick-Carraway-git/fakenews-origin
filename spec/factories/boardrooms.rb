FactoryBot.define do
  factory :boardroom do
    name { "MyString" }
    association :article, factory: :article
  end
end
