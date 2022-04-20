FactoryBot.define do
  factory :item do
    name { Faker::Food.dish }
    description { "Lorem Ipsum"}
    price { 10000.0 }
  end

  factory :invalid_item, parent: :item do
    name { nil }
    description { nil }
    price { 10000.0 }
  end
end
