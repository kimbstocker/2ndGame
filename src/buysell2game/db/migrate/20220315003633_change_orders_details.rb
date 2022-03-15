class ChangeOrdersDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :order_status, :string
    add_column :orders, :order_status, :integer, null: false, default: 1
  end
end
