FactoryBot.define do
  factory :customer do
    username { "test" }
    last_name { "test" }
    first_name { "taro" }
    email { Faker::Internet.email }
    password { "testuser" }
  end
end