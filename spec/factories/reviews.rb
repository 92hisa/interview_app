FactoryBot.define do
  factory :review do
    association :purchase
    association :user
    association :saler
    association :buyer
    score { 5 }
    content { "test" }
  end
end
