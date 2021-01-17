FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "News#{n}"}
  end
end
