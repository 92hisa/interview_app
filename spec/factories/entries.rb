FactoryBot.define do
  factory :entry do
    association :user
    association :dm_room
  end
end
