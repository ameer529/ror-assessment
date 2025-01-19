# spec/factories/blogs.rb
FactoryBot.define do
  factory :blog do
    title { Faker::Book.title }
    body { Faker::Lorem.paragraph }
    user
  end
end
