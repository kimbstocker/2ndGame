module ListingsHelper
    def format_condition(condition)
       condition.capitalize
    end 

    def format_category(category)
        category.capitalize
     end 

    def format_price(price)
        "$#{price}"
    end 


    
end
