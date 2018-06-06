class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string "name", :limit => 25, :null => false
      t.string "city", :limit => 25, :null => false
      t.timestamps
    end
  end
end
