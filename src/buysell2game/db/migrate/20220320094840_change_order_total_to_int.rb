class ChangeOrderTotalToInt < ActiveRecord::Migration[6.1]
  def change

    change_column :orders, :total, :integer

  end
end
