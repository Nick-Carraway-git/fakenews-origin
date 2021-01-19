FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Bot#{n}"}
    sequence(:email) { |n| "bot#{n}@example.com"}
    sequence(:password) { |n| "foobar#{n}"}
    sequence(:password_confirmation) { |n| "foobar#{n}"}
    after(:build) do |user|
      user.image.attach(io: File.open('spec/fixtures/sample.jpg'), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
