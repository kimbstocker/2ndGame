FactoryBot.define do
  factory :item do
    listing { nil }
    order { nil }
    price { 1.5 }
    sold { false }
  end
end
