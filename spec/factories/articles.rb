FactoryBot.define do
  factory :article do
    title { "MyText" }
    content { "MyText" }
    user { create(:user) }
    image_description { "AAA" }
    after(:build) do |article|
      article.image.attach(io: File.open('spec/fixtures/sample.jpg'), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end
