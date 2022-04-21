FactoryBot.define do
  factory :order do
    email { "MyString" }
    status_order { 1 }
    total_price { 1.5 }
  end
end
