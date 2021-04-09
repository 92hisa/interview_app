FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    post_id { 2 }
    association :user
    association :post
  end
end
