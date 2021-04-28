FactoryBot.define do
  factory :dm do
    association :user
    association :dm_room
    text { "test" }
  end
end
