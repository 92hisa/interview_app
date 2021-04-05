FactoryBot.define do
  factory :user do
    name { "foobar" }
    email { "foobar@foobar.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
