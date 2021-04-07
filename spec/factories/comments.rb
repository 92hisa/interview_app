FactoryBot.define do
  factory :comment do
    user_id { 1 }
    post_id { 2 }
    comment { "test" }
    association :user
    association :post
  end
end
