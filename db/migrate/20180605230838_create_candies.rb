class CreateCandies < ActiveRecord::Migration[5.2]
  def change
    create_table :candies do |t|
      t.string "name", :limit => 25, :null => false
      t.integer "amount", :null => false
      t.integer "shop_id", :null => false
      t.integer "shelf_id", :null => true
      t.timestamps
    end
    #Add index on foreign keys
    add_index("candies", "shop_id")
    add_index("candies", "shelf_id")
  end
end
