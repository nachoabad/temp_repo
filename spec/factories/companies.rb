FactoryBot.define do
  factory :company do
    name { "Default Company Name" }
    industry { "Default Industry" }
    employee_count { 100 }
    deals_count { 10 }
  end
end