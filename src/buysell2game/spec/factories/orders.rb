FactoryBot.define do
  factory :order do
    user_id { nil }
    total { 1.5 }
    order_status { "MyString" }
  end
end
