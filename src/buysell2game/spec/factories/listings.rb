FactoryBot.define do
  factory :listing do
    listing_name { "MyString" }
    condition { 1 }
    price { 1.5 }
    listing_status { 1 }
    description { "MyText" }
    user { nil }
    category { nil }
    shipping { 1 }
  end
end



# // <input name="listing_status" type="submit" value="listed" data-disable-with="listed" />
# // <input name="listing_status" type="submit" value="draft" data-disable-with="draft" />    
