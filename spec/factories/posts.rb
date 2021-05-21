FactoryBot.define do
  factory :post do
    title { "foobar" }
    subtitle { "sample_foobar" }
    price { 500 }
    experience { "rails" }
    detail { "nothing to do" }
    association :user
  end
end
