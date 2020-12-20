FactoryBot.define do
  factory :customer do
    username { "test" }
    last_name { "test" }
    first_name { "taro" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end