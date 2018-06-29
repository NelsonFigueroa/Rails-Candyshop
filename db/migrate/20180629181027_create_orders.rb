class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customer_id
      t.string :store_id
      t.string :candy_name
      t.decimal :candy_price, :precision => 10, :scale => 2
      t.integer :amount

      t.timestamps
    end
  end
end
