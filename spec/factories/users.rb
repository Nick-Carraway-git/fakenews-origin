FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Bot#{n}"}
    sequence(:email) { |n| "bot#{n}@example.com"}
    sequence(:password) { |n| "foobar#{n}"}
    sequence(:password_confirmation) { |n| "foobar#{n}"}
  end
end
