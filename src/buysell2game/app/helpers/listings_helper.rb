module ListingsHelper
    def format_enum(keys)
       arr = keys.split("_").map do |key|
        key.capitalize
       end
       arr.join(" ")
    end 

    def format_category(category)
        category.capitalize
     end 

    def format_price(price)
        "$#{price}"
    end 


    
end
