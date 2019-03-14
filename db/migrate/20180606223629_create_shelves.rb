class CreateShelves < ActiveRecord::Migration[5.2]
  def change
    create_table :shelves do |t|

      t.integer "shop_id"

      t.timestamps
    end
    add_index("shelves", "shop_id")
  end
end
