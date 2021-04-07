FactoryBot.define do
  factory :user do
    name { "foobar" }
    sequence(:email) { |n| "foobar#{n}@foobar.com" }
    password { "password" }
    password_confirmation { "password" }
    gender { "man" }
  end
end
