FactoryBot.define do
  factory :purchase do
    association :post
    user_id { 1 }
    post_id { 2 }
    saler_id { 3 }
    buyer_id { 1 }
  end
end
