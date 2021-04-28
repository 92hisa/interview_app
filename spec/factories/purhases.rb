FactoryBot.define do
  factory :purchase do
    association :post
    association :user
    association :saler
    association :buyer
  end
end
