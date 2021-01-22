FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Bot#{n}"}
    sequence(:email) { |n| "bot#{n}@example.com"}
    sequence(:password) { "foobar" }
    introduce { "Nice to meet you." }
    after(:build) do |user|
      user.image.attach(io: File.open('spec/fixtures/sample.jpg'), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
