FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number:20) }
    reference { Faker::Lorem.characters(number:5) }
    tag_list_id { Faker::Lorem.characters(number:5) }
    customer
  end
end