class ChangeOrderDetails < ActiveRecord::Migration[6.1]
  def change
    change_column_null :orders, :order_status, false
    change_column_null :items, :price, false
    change_column_null :items, :sold, false

  end
end
