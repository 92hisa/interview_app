FactoryBot.define do
  factory :post_category_relation do
    association :post
    association :category
  end
end
