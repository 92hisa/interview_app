FactoryBot.define do
  factory :message do
    association :room
    association :user
    message { "test" }
  end
end
