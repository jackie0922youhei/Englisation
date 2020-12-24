FactoryBot.define do
  factory :review do
    body { Faker::Lorem.characters(number:20) }
    rate { 2.5 }
    customer
    post
  end
end