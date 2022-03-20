class ChangePriceToInt < ActiveRecord::Migration[6.1]
  def change
    change_column :listings, :price, :integer
    change_column :items, :price, :integer

  end
end
