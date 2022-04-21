class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :email
      t.integer :status_order
      t.float :total_price

      t.timestamps
    end
  end
end
