FactoryBot.define do
  factory :order_detail do
    order { nil }
    item { nil }
    price { 1.5 }
    quantity { 1 }
  end
end
