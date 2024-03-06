FactoryBot.define do
  factory :deal do
    name { "Name" }
    amount { 100 }
    status { "Status" }
    company
  end
end
