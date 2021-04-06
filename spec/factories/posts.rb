FactoryBot.define do
  factory :post do
    title { "foobar" }
    fee { 100 }
    due_date { '2021-03-01' }
    experience { "rails" }
    detail { "nothing to do" }
  end
end
