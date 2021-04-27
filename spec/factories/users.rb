FactoryBot.define do
  factory :user, aliases: [:saler, :buyer, :visitor, :visited] do
    name { "foobar" }
    sequence(:email) { |n| "foobar#{n}@foobar.com" }
    password { "password" }
    password_confirmation { "password" }
    gender { "man" }
  end
end
