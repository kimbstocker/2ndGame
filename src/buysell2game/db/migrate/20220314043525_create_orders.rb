class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.float :total
      t.string :order_status, :default => "pending"

      t.timestamps
    end
  end
end
